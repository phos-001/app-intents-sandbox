import SwiftUI

@main
struct AppIntentsSandboxApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(TaskStore.shared)
    }
  }
}
