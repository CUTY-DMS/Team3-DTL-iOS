//
//  MainPostModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/04.
//

import Foundation

struct MainPostModel: Codable {
    let content: [Content]
}

struct Content: Codable {
    let username: String
    let title: String
    let content: String
}
