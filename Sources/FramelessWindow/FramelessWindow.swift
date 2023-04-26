import SwiftUI

public struct FramelessWindow<Content: View>: Scene {
    @Environment(\.scenePhase) private var scenePhase
    @State private  var window: NSWindow?
    let titleKey: LocalizedStringKey
    let id: String
    let content: () -> Content

    public var body: some Scene {
        Window(self.titleKey, id: self.id) {
            self.content()
                .ignoresSafeArea()
                .framelessWindow(self.$window)
        }.windowStyle(.hiddenTitleBar)
            .onChange(of: self.scenePhase, perform: self.adaptWindowToScenePhase(_:))
    }

    public init(withId id: String, andTitle titleKey: LocalizedStringKey = "Launcher", @ViewBuilder content: @escaping () -> Content) {
        self.titleKey = titleKey
        self.id = id
        self.content = content
    }

    private func adaptWindowToScenePhase(_ phase: ScenePhase) {
        guard phase != .background else {
            self.removeWindowFromEnvironment()
            return
        }
        guard self.window == nil else { return }
        guard let window = self.getWindowById() else { return }

        self.modify(window: window)
        self.addWindowToEnvironment(window)
    }

    private func addWindowToEnvironment(_ window: NSWindow) {
        self.window = window
    }

    private func removeWindowFromEnvironment() {
        self.window = nil
    }

    private func modify(window: NSWindow) {
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.isExcludedFromWindowsMenu = true
    }

    private func getWindowById() -> NSWindow? {
        for window in NSApplication.shared.windows {
            guard window.identifier?.rawValue == self.id else { continue }
            return window
        }
        return nil
    }
}
