//
//  Habit.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/12.
//

import Foundation

struct Habit {
    let name: String
    let categoty: Category
    let info: String
}


extension Habit: Codable { }

extension Habit: Hashable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Habit: Comparable {
    static func < (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name < rhs.name
    }
}
