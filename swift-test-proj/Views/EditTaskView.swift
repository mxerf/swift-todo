import SwiftUI

struct EditTaskView: View {
  @Environment(\.dismiss) var dismiss
  @State private var taskTitle: String
  @State private var taskCategory: TaskCategory
  @State private var isCompleted: Bool
  @ObservedObject var viewModel: TaskViewModel

  private(set) var task: Task

  init(task: Task, viewModel: TaskViewModel) {
    self.task = task
    self.viewModel = viewModel
    _taskTitle = State(initialValue: task.title)
    _taskCategory = State(initialValue: task.category)
    _isCompleted = State(initialValue: task.isCompleted)
  }

  var body: some View {
    VStack {
      Text("Редактирование")
        .font(.title.bold())
        .padding()
        .multilineTextAlignment(.center)

      TextField("Имя задачки...", text: $taskTitle)
        .padding()
        .font(.title3)

      Picker("Категория", selection: $taskCategory) {
        ForEach(TaskCategory.allCases, id: \.self) { category in
          Text(category.rawValue)
            .tag(category)
            .background(Color.cyan)
        }
      }
      .pickerStyle(PalettePickerStyle())  // Красивый вид
      .padding()

      Spacer()

      Button(action: {
        viewModel.updateTask(
          task: task,
          title: taskTitle,
          isCompleted: isCompleted,
          category: taskCategory
        )
        dismiss()
      }) {
        Text("Сохранить")
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.green)
          .cornerRadius(CORNER_RADIUS)
          .padding(.horizontal)
      }

      Button(action: {
        viewModel.removeTask(task: task)
        dismiss()
      }) {
        Text("Удалить")
          .foregroundColor(.red)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.red.opacity(0.15))
          .cornerRadius(CORNER_RADIUS)
          .padding(.horizontal)
      }
    }
    .padding()
  }
}
