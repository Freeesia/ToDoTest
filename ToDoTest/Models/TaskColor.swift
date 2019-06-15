//
//  TaskColor.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import SwiftUI

enum TaskColor: CaseIterable {
    case red
    case blue
    case green
    case yellow
    case pink
    case orange
    case purple

    var color: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .pink:
            return .pink
        case .orange:
            return .orange
        case .purple:
            return .purple
        }
    }
}
