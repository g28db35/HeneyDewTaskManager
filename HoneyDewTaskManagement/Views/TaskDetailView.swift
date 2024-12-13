//
//  TaskDetailView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/25/24.
//

import SwiftUI
import SwiftData

struct TaskDetailView: View {
    @Bindable var task: Task
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var editedTitle: String = ""
    @State private var editedDescription: String = ""
    @State private var editedDueDate: Date = Date()
    @State private var editedPriority: TaskPriority = .medium
    @State private var editedCategory: TaskCategory = .other
    
    var body: some View {
        NavigationStack {
            Form {
                if !isEditing {
                    Section(header: Text("Task Information")) {
                        HStack {
                            Image(systemName: task.category.icon)
                                .foregroundColor(task.category.color)
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                        }
                        
                        if !task.desc.isEmpty {
                            Text(task.desc)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Due Date")
                            Spacer()
                            Text(task.dueDate, style: .date)
                        }
                        
                        HStack {
                            Text("Priority")
                            Spacer()
                            Text(task.priority.title)
                                .foregroundColor(task.priority.color)
                        }
                        
                        HStack {
                            Text("Category")
                            Spacer()
                            Text(task.category.rawValue.capitalized)
                        }
                        
                        Toggle("Completed", isOn: $task.isCompleted)
                    }
                }
                if isEditing {
                    Section(header: Text("Edit Task")) {
                        TextField("Task Title", text: $editedTitle)
                        TextField("Description", text: $editedDescription)
                        
                        DatePicker("Due Date", selection: $editedDueDate, displayedComponents: .date)
                        
                        Picker("Priority", selection: $editedPriority) {
                            ForEach([TaskPriority.low, .medium, .high], id: \.self) { priorityLevel in
                                Text(priorityLevel.title).tag(priorityLevel)
                            }
                        }
                        
                        Picker("Category", selection: $editedCategory) {
                            ForEach(TaskCategory.allCases) { categoryItem in
                                HStack {
                                    Image(systemName: categoryItem.icon)
                                    Text(categoryItem.rawValue.capitalized)
                                }
                                .tag(categoryItem)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Task Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isEditing {
                            saveEditedTask()
                        } else {
                            startEditing()
                        }
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if isEditing {
                            cancelEditing()
                        } else {
                            dismiss()
                        }
                    }) {
                      //  Text(isEditing ? "Cancel" : "Back")
                    }
                }
            }
            .onAppear {
                resetEditedValues()
            }
        }
    }
    
    private func resetEditedValues() {
        editedTitle = task.title
        editedDescription = task.desc
        editedDueDate = task.dueDate
        editedPriority = task.priority
        editedCategory = task.category
    }
    
    private func startEditing() {
        isEditing.toggle()
    }
    
    private func cancelEditing() {
        if isEditing {
            resetEditedValues()
            isEditing.toggle()
        } else {
            dismiss()
        }
    }
    
    private func saveEditedTask() {
        task.title = editedTitle
        task.desc = editedDescription
        task.dueDate = editedDueDate
        task.priority = editedPriority
        task.category = editedCategory
        
        do {
            try modelContext.save()
            isEditing.toggle()
        } catch {
            print("Error saving edited task: \(error)")
        }
    }
}



/*
#Preview {
    TaskDetailView()
}
*/
