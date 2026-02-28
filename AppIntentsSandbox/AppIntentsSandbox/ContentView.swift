import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var taskStore: TaskStore
  @State private var showingAddTask = false

  var body: some View {
    NavigationStack {
      Group {
        if taskStore.tasks.isEmpty {
          emptyStateView
        } else {
          taskListView
        }
      }
      .navigationTitle("タスク")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            showingAddTask = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $showingAddTask) {
        AddTaskView()
      }
    }
  }

  private var taskListView: some View {
    List {
      ForEach(taskStore.tasks) { task in
        TaskRowView(task: task) {
          taskStore.toggleCompletion(id: task.id)
        }
      }
      .onDelete { offsets in
        taskStore.delete(at: offsets)
      }
    }
  }

  private var emptyStateView: some View {
    VStack(spacing: 16) {
      Image(systemName: "checklist")
        .font(.system(size: 60))
        .foregroundStyle(.secondary)
      Text("タスクがありません")
        .font(.headline)
        .foregroundStyle(.secondary)
      Text("「＋」ボタンまたはSiriでタスクを追加できます。")
        .font(.subheadline)
        .foregroundStyle(.tertiary)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
  }
}

// MARK: - TaskRowView

struct TaskRowView: View {
  let task: AppTask
  let onToggle: () -> Void

  var body: some View {
    Button(action: onToggle) {
      HStack(spacing: 12) {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
          .foregroundStyle(task.isCompleted ? Color.accentColor : .secondary)
          .imageScale(.large)

        Text(task.title)
          .strikethrough(task.isCompleted, color: .secondary)
          .foregroundStyle(task.isCompleted ? .secondary : .primary)

        Spacer()
      }
    }
    .buttonStyle(.plain)
  }
}

// MARK: - AddTaskView

struct AddTaskView: View {
  @EnvironmentObject private var taskStore: TaskStore
  @Environment(\.dismiss) private var dismiss

  @State private var title = ""

  var body: some View {
    NavigationStack {
      Form {
        Section("タスク名") {
          TextField("例：買い物をする", text: $title)
            .submitLabel(.done)
            .onSubmit(addTask)
        }
      }
      .navigationTitle("新しいタスク")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("キャンセル") { dismiss() }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button("追加", action: addTask)
            .bold()
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
        }
      }
    }
  }

  private func addTask() {
    let trimmed = title.trimmingCharacters(in: .whitespaces)
    guard !trimmed.isEmpty else { return }
    taskStore.add(title: trimmed)
    dismiss()
  }
}
