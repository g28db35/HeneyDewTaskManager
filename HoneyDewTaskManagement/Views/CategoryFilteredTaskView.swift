//
//  CategoryFilteredTaskView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/24/24.
//

import SwiftUI
import SwiftData

struct CategoryFilteredTaskView: View {
    let category: TaskCategory
    @Query private var tasks: [Task]
    
    init(category: TaskCategory) {
        self.category = category
        _tasks = Query(filter: #Predicate { $0.category == category })
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRowView(task: task)
        }
        .navigationTitle("\(category.rawValue.capitalized) Tasks")
    }
}
/*
#Preview {
    CategoryFilteredTaskView()
}
*/
