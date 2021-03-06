//
//  APIService.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/15.
//

import Foundation

struct HabitRequest: APIRequest {
    typealias Response = [String: Habit]

    var habitName: String?

    var path: String { "/habits" }
}

struct UserRequest: APIRequest {
    typealias Response = [String: User]
    
    var path: String { "/users" }
}


struct HabitStatisticsRequest: APIRequest {
    typealias Response = [HabitStatistics]

    var habitNames: [String]?

    var path: String { "/habitStats" }

    var queryItems: [URLQueryItem]? {
        if let habitNames = habitNames {
            return [URLQueryItem(name: "names",
               value: habitNames.joined(separator: ","))]
        } else {
            return nil
        }
    }
}
