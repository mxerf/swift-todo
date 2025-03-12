

import SwiftUI

class TaskViewModel: ObservableObject {
  @Published var tasks: [Task] = [] {
    didSet {
      saveTasks()
    }
  }

  let tasksKey = "tasks"

  init() {
    loadTasks()
  }

  private func saveTasks() {
    if let encoded = try? JSONEncoder().encode(tasks) {
      UserDefaults.standard.set(encoded, forKey: tasksKey)
    }
  }

  private func loadTasks() {
    if let savedData = UserDefaults.standard.data(forKey: tasksKey),
      let decoded = try? JSONDecoder().decode([Task].self, from: savedData)
    {
      tasks = decoded
    }
  }

  func addTask(title: String, category: TaskCategory) {
    withAnimation {
      let newTask = Task(
        title: title, isCompleted: false, category: category, dueDate: nil)
      tasks.append(newTask)
    }
  }

  func updateTask(
    task: Task,
    title: String,
    isCompleted: Bool,
    category: TaskCategory
  ) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks[index].title = title
      tasks[index].isCompleted = isCompleted
      tasks[index].category = category
    }
  }

  func toggleCompletion(task: Task) {
    withAnimation {
      if let index = tasks.firstIndex(where: { $0.id == task.id }) {
        tasks[index].isCompleted.toggle()
      }
    }
  }

  func removeTask(task: Task) {
    withAnimation {
      if let index = tasks.firstIndex(where: { $0.id == task.id }) {
        tasks.remove(at: index)
      }
    }
  }

  func deleteTask(at offsets: IndexSet) {
    withAnimation {
      tasks.remove(atOffsets: offsets)
    }
  }

}
