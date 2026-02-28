import AppIntents

/// Siriやショートカットからタスク一覧を取得するAppIntent
struct ListTasksIntent: AppIntent {
    static var title: LocalizedStringResource = "タスク一覧を表示"
    static var description = IntentDescription(
        "現在のタスク一覧を返します。",
        categoryName: "タスク管理"
    )

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        let tasks = TaskStore.shared.tasks
        if tasks.isEmpty {
            return .result(value: "", dialog: "タスクはまだありません。")
        }
        let lines = tasks.map { task in
            let mark = task.isCompleted ? "✓" : "○"
            return "[\(mark)] \(task.title)"
        }
        let summary = lines.joined(separator: "\n")
        return .result(
            value: summary,
            dialog: "タスクが\(tasks.count)件あります。\n\(summary)"
        )
    }
}
