import SwiftUI
import FramelessWindow

struct TestApp: App {
	var body: some Scene {
		FramelessWindow(withId: "single-window", andTitle: "Single Window") {
			VStack {
				Image(systemName: "globe").font(.title).foregroundStyle(.blue)
				Text("Hello, world!")
			}
		}
	}
}

DispatchQueue.main.async {
	let app = NSApplication.shared
	app.setActivationPolicy(.regular)
	app.activate(ignoringOtherApps: true)
}

TestApp.main()
