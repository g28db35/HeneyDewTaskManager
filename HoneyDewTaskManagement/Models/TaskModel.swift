//
//  TaskModel.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/23/24.
//

import Foundation
import SwiftData
import SwiftUI

/* Define the task model*/
@Model
class Task {
    var id: UUID
    var title: String
    var desc: String
    var dueDate: Date
    var priority: TaskPriority
    var isCompleted: Bool
    var category: TaskCategory // New property
    
    init(title: String,
         description: String = "",
         dueDate: Date = Date(),
         priority: TaskPriority = .medium,
         isCompleted: Bool = false,
         category: TaskCategory = .other) {
        self.id = UUID()
        self.title = title
        self.desc = description
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.category = category
    }
}

/* Task category icon and color for View*/
enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case maintenance
    case improvement
    case shopping
    case celebration
    case travel
    case other
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .maintenance: return "house"
        case .improvement: return "hammer"
        case .shopping: return "cart"
        case .celebration: return "party.popper"
        case .travel: return "airplane"
        case .other: return "ellipsis"

        }
    }
    
    var color: Color {
        switch self {
        case .maintenance: return .blue
        case .improvement: return .green
        case .shopping: return .orange
        case .celebration: return .red
        case .travel: return .purple
        case .other: return .gray
        }
    }
}

enum TaskPriority: Int, Codable, Hashable {
    case low
    case medium
    case high
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
    
    var title: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
}

