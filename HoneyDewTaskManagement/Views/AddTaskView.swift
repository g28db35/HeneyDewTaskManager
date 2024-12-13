//
//  AddTaskView.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/25/24.
//

import SwiftUI
import SwiftData

/* Capstone requirement 8 - Store task data on device using SwiftData*/
struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority: TaskPriority = .medium
    @State private var category: TaskCategory = .other
    
    // Validation state
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Title", text: $title)
                        .autocorrectionDisabled()
                    
                    TextField("Description (Optional)", text: $description)
                        .autocorrectionDisabled()
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach([TaskPriority.low, .medium, .high], id: \.self) { priorityLevel in
                            Text(priorityLevel.title).tag(priorityLevel)
                        }
                    }
                    
                    Picker("Category", selection: $category) {
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
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTask()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private func saveTask() {
        let newTask = Task(
            title: title.trimmingCharacters(in: .whitespaces),
            description: description.trimmingCharacters(in: .whitespaces),
            dueDate: dueDate,
            priority: priority,
            category: category
        )
        
        modelContext.insert(newTask)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving task record: \(error)")
        }
    }
}

/*
#Preview {
    AddTaskView()
}
*/
