//
//  RealmManager.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/28.
//

import Foundation
import RealmSwift


enum RealmError: Error {
    case writeError
    case updateError
    case deleteError
}


struct RealmManager<T: Object> {
    
    private let localRealm = try! Realm()
    
    // Database Table
    var database: Results<T>
    
    var count: Int { database.count }
    
    // Table Type 저장
    private var objectType: T.Type
    
    // 정렬 기준 저장
    private var byKeyPath: String
    private var ascending: Bool
    
    // Observer 토큰
    private var notificationToken: NotificationToken?
    
    
    
    // init
    init(_ objectType: T.Type, byKeyPath: String, ascending: Bool) {
        self.byKeyPath = byKeyPath
        self.ascending = ascending
        self.objectType = objectType
        self.database = localRealm.objects(objectType).sorted(byKeyPath: byKeyPath, ascending: ascending)
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    
    
    // Create(add)
    func write(_ object: T) throws {
        do {
            try localRealm.write {
                localRealm.add(object)
            }
        }
        catch {
            throw RealmError.writeError
        }
    }
    
    
    
    func getData(at index: Int) -> T {
        return database[index]
    }
    
    
    
    // Read
    mutating private func fetchData() {
        database = localRealm.objects(objectType).sorted(byKeyPath: byKeyPath, ascending: ascending)
    }
    
    
    
    // 정렬 기준 변경
    mutating func changeSort(byKeyPath: String, ascending: Bool) {
        self.byKeyPath = byKeyPath
        self.ascending = ascending
        fetchData()
    }
    
    
    
    // Update
    func update(at index: Int, completion: (T) -> Void) throws {
        let dataToUpdate = database[index]
        
        do {
            try localRealm.write({
                completion(dataToUpdate)
            })
        }
        catch {
            throw RealmError.updateError
        }
    }
    
    
    
    // Delete
    func remove(at index: Int) throws {
        let dataToDelete = database[index]
        
        do {
            try localRealm.write {
                localRealm.delete(dataToDelete)
            }
        }
        catch {
            throw RealmError.deleteError
        }
    }
    
    
    
    // Observer 달기
    mutating func addObserver(completion: @escaping () -> Void) {
        notificationToken = database.observe { _ in
            completion()
        }
    }
}
