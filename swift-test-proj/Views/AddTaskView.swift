
import SwiftUI


struct AddTaskView: View {
  @Environment(\.dismiss) var dismiss
  @State private var taskTitle = ""
  @State private var taskCategory: TaskCategory = .personal
  @State private var taskStartDate: Date = Date()
  @State private var taskEndDate: Date = Date()
  @ObservedObject var viewModel: TaskViewModel

  var body: some View {
    VStack {
      Text("Новая задача")
        .font(.title.bold())
        .padding()

      TextField("Имя задачки...", text: $taskTitle)
        .padding()
        .font(.title3)

      Picker("Категория", selection: $taskCategory) {
        ForEach(TaskCategory.allCases, id: \.self) { category in
          Text(category.rawValue).tag(category)
        }
      }
      .pickerStyle(PalettePickerStyle())
      .padding()

      VStack {
        DatePicker(
          "Выбрать день",
          selection: $taskStartDate,
          displayedComponents: DatePickerComponents.date
        )
      }
      .padding()

      Button(action: {
        viewModel.addTask(title: taskTitle, category: taskCategory)
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

      Spacer()
    }
    .padding()
  }
}
