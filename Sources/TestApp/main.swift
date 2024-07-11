import SwiftUI
import FramelessWindow

struct TestApp: App {
	var body: some Scene {
		FramelessWindow("Single Window", id: "single-window") {
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
