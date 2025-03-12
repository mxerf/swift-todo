
import SwiftUI

struct TaskRowView: View {
  let task: Task
  @State private var isEditOpen: Bool = false
  @ObservedObject var viewModel: TaskViewModel

  func kek() {
    print("something")
  }

  var body: some View {
    HStack {
      Button(action: {
        isEditOpen.toggle()
      }) {
        Image(
          systemName:
            task.isCompleted ? "checkmark.circle.fill" : "circle"
        )
        .foregroundColor(task.isCompleted ? .green : .gray)
        .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
        .onTapGesture {
          viewModel.toggleCompletion(task: task)
        }
      }

      Text(task.title)
        .strikethrough(task.isCompleted, color: .gray)
        .foregroundColor(task.isCompleted ? .gray : .primary)
        .animation(.easeInOut(duration: 0.2), value: task.isCompleted)

      Spacer()

      Text(task.category.rawValue)
        .font(.caption)
        .padding(5)
        .background(Color(task.category.color))
        .cornerRadius(5)
        .foregroundColor(.white)
    }
    .padding(.vertical, 5)
    .sheet(isPresented: $isEditOpen) {
      EditTaskView(task: task, viewModel: viewModel)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(CORNER_RADIUS * 2)
    }

  }

}
