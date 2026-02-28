import AppIntents

/// Siriやショートカットからタスクを追加するAppIntent
struct AddTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "タスクを追加"
    static var description = IntentDescription(
        "新しいタスクをリストに追加します。",
        categoryName: "タスク管理"
    )

    @Parameter(title: "タスク名", description: "追加するタスクの名前を入力してください。")
    var taskTitle: String

    static var parameterSummary: some ParameterSummary {
        Summary("「\(\.$taskTitle)」をタスクに追加")
    }

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        let trimmed = taskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            throw $taskTitle.needsValueError("タスク名を入力してください。")
        }
        TaskStore.shared.add(title: trimmed)
        return .result(
            value: trimmed,
            dialog: "「\(trimmed)」をタスクに追加しました。"
        )
    }
}
