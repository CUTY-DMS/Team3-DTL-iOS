//
//  MyPostModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/27.
//

import Foundation

struct MyPostModel: Codable {
    var user_name: String = .init()
    var user_id: String = .init()
    var user_age: Int = .init()
    var todos = [TodosModel]()
}

struct TodosModel: Codable {
    var id: Int = .init()
    var title: String = .init()
    var content: String = .init()
    var created_at: String = .init()
    var like_count: Int = .init()
    var success: Bool = .init()
}


