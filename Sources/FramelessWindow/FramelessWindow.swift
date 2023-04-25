import SwiftUI

public struct FramelessWindow<Content: View>: Scene {
    let title: String
    let id: String
    let content: () -> Content

    public var body: some Scene {
        Window(self.title, id: self.id) {
            WindowButtonsModifier(for: self.id, with: self.content)
        }.windowStyle(.hiddenTitleBar)
    }

    public init(_ title: String, id: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.id = id
        self.content = content
    }
}

struct WindowButtonsModifier<Content: View>: View {
    @Environment(\.scenePhase) private var scenePhase
    let windowId: String
    let content: () -> Content

    var body: some View {
        self.content()
            .onChange(of: self.scenePhase) { phase in
                guard phase != .background else { return }
                for window in NSApplication.shared.windows {
                    guard window.identifier?.rawValue == self.windowId else {
                        return
                    }
                    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    window.standardWindowButton(.zoomButton)?.isHidden = true
                }
        }
    }

    init(for windowId: String, with content: @escaping () -> Content) {
        self.windowId = windowId
        self.content = content
    }
}
