//
//  ShoppingListModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import Foundation
import RealmSwift

struct ShoppingListManager {
    
    // MARK: - Propertys
    let localRealm = try! Realm()
    
    private var shoppingList: Results<Shopping>
    
    var count: Int { return shoppingList.count }
    
    
    // MARK: - Init
    init() {
        shoppingList = localRealm.objects(Shopping.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    
    
    // MARK: - Methods
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
        shoppingList = localRealm.objects(Shopping.self)
    }
    
    
    mutating func importantTapped(index: Int) {
        let taskToUpdate = shoppingList[index]
        try! localRealm.write {
            taskToUpdate.isImportant.toggle()
        }
        shoppingList = localRealm.objects(Shopping.self)
    }
}
