//
//  ShoppingListModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit
import RealmSwift


enum SortBy {
    case title
    case important
    case finished
    case none
}


struct ShoppingListManager {
    
    // MARK: - Propertys
    let localRealm = try! Realm()
    
    private var shoppingList: Results<Shopping>
    
    var count: Int { return shoppingList.count }
    
    var currentSortBy: SortBy = .none
    
    
    
    
    // MARK: - Init
    init() {
        shoppingList = localRealm.objects(Shopping.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    
    
    
    // MARK: - Methods - Realm
    mutating func readData() {
        switch currentSortBy {
        case .title:
            shoppingList = localRealm.objects(Shopping.self).sorted(byKeyPath: "title", ascending: true)
        case .important:
            shoppingList = localRealm.objects(Shopping.self).sorted(byKeyPath: "isImportant", ascending: true)
        case .finished:
            shoppingList = localRealm.objects(Shopping.self).sorted(byKeyPath: "isFinish", ascending: true)
        case .none:
            shoppingList = localRealm.objects(Shopping.self)
        }
    }
    
    
    func getMemo(at index: Int) -> Shopping{
        return shoppingList[index]
    }
    
    
    mutating func addMemo(title: String, image: UIImage? = nil) {
        let task = Shopping(title: title)
        try! localRealm.write {
            localRealm.add(task)
        }
        
        if let image = image {
            saveImageToDocument(fileName: "\(task.objectId)", image: image)
        }
    }
    
    
    mutating func removeMemo(at index: Int) {
        let taskToDelete = shoppingList[index]
        
        removeImageFromDocument(fileName: "\(taskToDelete.objectId)")
        
        try! localRealm.write {
            localRealm.delete(taskToDelete)
        }
    }
    
    
    mutating func finishTapped(index: Int) {
        let taskToUpdate = shoppingList[index]
        try! localRealm.write {
            taskToUpdate.isFinish.toggle()
        }
    }
    
    
    mutating func importantTapped(index: Int) {
        let taskToUpdate = shoppingList[index]
        try! localRealm.write {
            taskToUpdate.isImportant.toggle()
        }
    }
    
    
    
    
    // MARK: - Methods - Document
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        }catch let error {
            print(error)
        }
    }
    
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        }catch let error {
            print(error)
        }
    }
}
