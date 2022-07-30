//
//  DetailModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/30.
//

import Foundation

struct DetailModel: Codable {
    var title: String = .init()
    var content: String = .init()
    var user_name: String = .init()
    var like_count: Int = .init()
    var created_at: String = .init()
    var liked: Bool = .init()
    var success: Bool = .init()
}
