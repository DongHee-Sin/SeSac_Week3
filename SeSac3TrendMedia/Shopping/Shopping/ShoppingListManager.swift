//
//  ShoppingListModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import Foundation
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
    
    
    
    // MARK: - Methods
    
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
    
    
    mutating func addMemo(title: String) {
        let task = Shopping(title: title)
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    
    mutating func removeMemo(at index: Int) {
        let taskToDelete = shoppingList[index]
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
}
