//
//  TaskListView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/25/24.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    @Query(sort: \Task.dueDate) private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddTaskView = false
    
    var body: some View {
        /* Capstone requirement 5 & 6 to use List view and Navigation stack*/
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task)
                    }
                }
                .onDelete(perform: deleteTasks)

            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTaskView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTaskView) {
                AddTaskView()
            }
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            modelContext.delete(task)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error deleting tasks: \(error)")
        }
    }
}

#Preview {
    TaskListView()
}
