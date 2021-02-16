//
//  UserCount.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/16.
//

import Foundation

struct UserCount {
    let user: User
    let count: Int
}

extension UserCount: Codable { }

extension UserCount: Hashable { }

