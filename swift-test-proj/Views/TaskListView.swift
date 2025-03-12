

import SwiftUI

struct TaskListView: View {
  @ObservedObject var viewModel: TaskViewModel
  @State var isSettingsPresented: Bool = false

  var body: some View {
    NavigationView {
      List {
        if !viewModel.tasks.filter({ !$0.isCompleted }).isEmpty {
          Section(header: Text("Активные задачи").font(.subheadline.bold())) {
            ForEach(viewModel.tasks.filter { !$0.isCompleted }, id: \.id) {
              task in
              TaskRowView(task: task, viewModel: viewModel)
                .transition(.move(edge: .leading))
            }
            .onDelete(perform: viewModel.deleteTask)
          }
        }
        if !viewModel.tasks.filter({ $0.isCompleted }).isEmpty {
          Section(
            header: Text("Выполненные задачи")
              .font(.subheadline.bold())
              .foregroundColor(
                .gray)
          ) {
            ForEach(viewModel.tasks.filter { $0.isCompleted }, id: \.id) {
              task in
              TaskRowView(task: task, viewModel: viewModel)
                .transition(.move(edge: .trailing))
            }
            .onDelete(perform: viewModel.deleteTask)
          }
        }
      }
      .animation(.default, value: viewModel.tasks)
      .listStyle(SidebarListStyle())
      .navigationTitle("Мои задачки")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            isSettingsPresented.toggle()
          }) {
            Image(systemName: "gearshape")
          }
        }
      }
    }
  }
}
