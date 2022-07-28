//
//  MyPostModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/27.
//

import Foundation

struct MyPostModel: Codable {
    var user_name: String
    var user_id: String
    var user_age: Int
    var todos = [TodosModel]()
}

struct TodosModel: Codable {
    var id: Int
    var title: String
    var content: String
    var created_at: String
    var like_count: Int
    var success: Bool
}



