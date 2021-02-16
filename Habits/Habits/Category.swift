//
//  File.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/12.
//

import Foundation

struct Category {
    let name: String
    let color: Color
    
}

extension Category: Codable { }

extension Category: Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
