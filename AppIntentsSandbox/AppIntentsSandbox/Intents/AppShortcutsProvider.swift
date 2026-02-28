import AppIntents

/// アプリのSiriショートカットフレーズを定義するプロバイダ
struct TaskShortcutsProvider: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: AddTaskIntent(),
      phrases: [
        "タスクを追加 \(.applicationName)",
        "\(.applicationName)でタスクを追加",
        "Add a task to \(.applicationName)",
        "\(.applicationName) add task"
      ],
      shortTitle: "タスクを追加",
      systemImageName: "plus.circle.fill"
    )
    AppShortcut(
      intent: ListTasksIntent(),
      phrases: [
        "\(.applicationName)のタスクを確認",
        "\(.applicationName)でタスク一覧",
        "Show my tasks in \(.applicationName)",
        "List tasks in \(.applicationName)"
      ],
      shortTitle: "タスク一覧",
      systemImageName: "checklist"
    )
  }
}
