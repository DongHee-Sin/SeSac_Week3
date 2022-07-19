//
//  ShoppingListModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import Foundation


struct ShoppingMemo {
    private(set) var title: String
    private(set) var isSelected: Bool = false
    private(set) var isImportant: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    mutating func modifyTitle(to title: String) {
        self.title = title
    }
    
    mutating func selectedTapped() {
        self.isSelected.toggle()
    }
    
    mutating func importantTapped() {
        self.isImportant.toggle()
    }
}



struct ShoppingListManager {
    private var shoppingList: [ShoppingMemo]
    
    init() {
        shoppingList = [
            ShoppingMemo(title: "그립톡 구매하기"),
            ShoppingMemo(title: "사이다 구매"),
            ShoppingMemo(title: "아이패드 케이스 최저가 알아보기"),
            ShoppingMemo(title: "양말")
        ]
    }
    
    
    func getListCount() -> Int {
        return shoppingList.count
    }
    
    
    func getMemo(at index: Int) -> ShoppingMemo{
        return shoppingList[index]
    }
    
    
    mutating func addMemo(title: String) {
        shoppingList.append(ShoppingMemo(title: title))
    }
    
    
    mutating func removeMemo(at index: Int) {
        shoppingList.remove(at: index)
    }
}
