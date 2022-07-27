//
//  Movie.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/20.
//

import Foundation

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
}


class User {
    let name: String
    let age: Int
    let rage: Double
    let gender: Bool
    
    init(name: String, age: Int, rage: Double, gender: Bool) {
        self.name = name
        self.age = age
        self.rage = rage
        self.gender = gender
    }
    
}
