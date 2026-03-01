import Foundation
import Combine

/// タスクモデル
struct AppTask: Identifiable, Codable, Hashable {
  var id: UUID
  var title: String
  var isCompleted: Bool

  init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
  }
}

/// タスクの状態を管理するシングルトンストア
/// AppIntentsとSwiftUI UIの両方からアクセスするために共有インスタンスを使用します。
class TaskStore: ObservableObject {
  static let shared = TaskStore()

  @Published private(set) var tasks: [AppTask] = []

  private let saveKey = "AppIntentsSandbox.tasks"

  init() {
    load()
  }

  func add(title: String) {
    tasks.append(AppTask(title: title))
    save()
  }

  func delete(at offsets: IndexSet) {
    tasks.remove(atOffsets: offsets)
    save()
  }

  func toggleCompletion(id: UUID) {
    guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
    tasks[index].isCompleted.toggle()
    save()
  }

  /// タスクタイトルで検索して最初の一致を削除します（大文字小文字区別なし）
  @discardableResult
  func deleteFirst(matching title: String) -> Bool {
    guard let index = tasks.firstIndex(where: {
      $0.title.lowercased() == title.lowercased()
    }) else { return false }
    tasks.remove(at: index)
    save()
    return true
  }

  private func save() {
    guard let encoded = try? JSONEncoder().encode(tasks) else { return }
    UserDefaults.standard.set(encoded, forKey: saveKey)
  }

  private func load() {
    guard
      let data = UserDefaults.standard.data(forKey: saveKey),
      let decoded = try? JSONDecoder().decode([AppTask].self, from: data)
    else { return }
    tasks = decoded
  }
}
