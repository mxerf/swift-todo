

import Foundation
import UIKit

struct Task: Identifiable, Codable, Equatable {
  let id: UUID
  var title: String
  var isCompleted: Bool
  var category: TaskCategory
  var dueDate: Date?

  init(
    id: UUID = UUID(),
    title: String,
    isCompleted: Bool,
    category: TaskCategory,
    dueDate: Date? = nil
  ) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
    self.category = category
    self.dueDate = dueDate
  }

  static func == (lhs: Task, rhs: Task) -> Bool {
    return lhs.id == rhs.id && lhs.title == rhs.title
      && lhs.isCompleted == rhs.isCompleted && lhs.category == rhs.category
  }

}

enum TaskCategory: String, CaseIterable, Codable {
  case work = "Работа"
  case personal = "Личное"
  case shopping = "Покупки"
  case other = "Другое"

  var color: UIColor {
    switch self {
    case .work: return UIColor.systemBlue
    case .personal: return UIColor.systemGreen
    case .shopping: return UIColor.systemOrange
    case .other: return UIColor.gray
    }
  }
}
