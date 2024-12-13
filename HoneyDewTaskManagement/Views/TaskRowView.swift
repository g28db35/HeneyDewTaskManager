//
//  TaskRowView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/25/24.
//

import SwiftUI

import SwiftData

struct TaskRowView: View {
    let task: Task
    
    var body: some View {
        HStack {
            // Category Icon
            Image(systemName: task.category.icon)
                .foregroundColor(task.category.color)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                Text(task.desc)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(task.priority.title)
                    .font(.caption)
                    .foregroundColor(task.priority.color)
                Text(task.category.rawValue.capitalized)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

