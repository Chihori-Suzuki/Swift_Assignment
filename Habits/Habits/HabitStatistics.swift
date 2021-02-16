//
//  HabitStatistics.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/16.
//

import Foundation

struct HabitStatistics {
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable { }

