//
//  MainPostModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/04.
//

import Foundation

struct MainPostModel: Codable {
    var id: Int
    var content: String
    var title: String
    var created_at: String
    var member_id: String
    var like_count: Int
    var todo_success: Bool
}

