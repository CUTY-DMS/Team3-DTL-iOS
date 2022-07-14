//
//  TokenModel.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/06.
//

import Foundation

struct TokenModel: Codable {
    var accessToken: String
    var refreshToken: String
}
