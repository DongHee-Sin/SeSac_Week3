//
//  RealmModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/22.
//

import Foundation
import RealmSwift


class Shopping: Object {
    @Persisted var title: String
    @Persisted var isFinish: Bool
    @Persisted var isImportant: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.isFinish = false
        self.isImportant = false
    }
}
