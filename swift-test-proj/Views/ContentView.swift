
import SwiftUI

let CORNER_RADIUS = 16.0

struct ContentView: View {
  @StateObject var viewModel = TaskViewModel()
  @State private var isAddingTask: Bool = false

  var body: some View {
    VStack {
      TaskListView(viewModel: viewModel)
      Button(action: {
        isAddingTask.toggle()
      }) {
        Text("Добавить задачу")
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(CORNER_RADIUS)
          .padding(.horizontal)
      }
    }
    .sheet(isPresented: $isAddingTask) {
      AddTaskView(viewModel: viewModel)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(CORNER_RADIUS * 2)
    }
  }
}

#Preview {
  ContentView()
}


