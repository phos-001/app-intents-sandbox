import AppIntents

/// アプリのSiriショートカットフレーズを定義するプロバイダ
struct TaskShortcutsProvider: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: AddTaskIntent(),
      phrases: [
        "タスクを追加 TODOアプリ",
        "TODOアプリでタスクを追加",
        "Add a task to TODOアプリ",
        "TODOアプリ add task"
      ],
      shortTitle: "タスクを追加",
      systemImageName: "plus.circle.fill"
    )
    AppShortcut(
      intent: ListTasksIntent(),
      phrases: [
        "TODOアプリのタスクを確認",
        "TODOアプリでタスク一覧",
        "Show my tasks in TODOアプリ",
        "List tasks in TODOアプリ"
      ],
      shortTitle: "タスク一覧",
      systemImageName: "checklist"
    )
  }
}
