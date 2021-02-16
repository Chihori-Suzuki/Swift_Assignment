//
//  Color.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/12.
//

import Foundation

struct Color {
    let hue: Double
    let saturation: Double
    let brightness: Double
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case hue = "h"
        case saturation = "s"
        case brightness = "b"
        
    }
}
