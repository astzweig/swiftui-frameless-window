import SwiftUI

/**
 A SwiftUI scene that creates a bare single window without the included default items.
 
 A frameless window does not include a title bar and neither the minimize nor the zoom
 default window buttons. Additionally it is excluded from the applications window menu.
 */
public struct FramelessWindow<Content: View>: Scene {
    /// Store the window in local state to share within the environment.
    @State private  var window: NSWindow?
    @Environment(\.scenePhase) private var scenePhase

    let titleKey: LocalizedStringKey
    let id: String
    let content: () -> Content

    /// A `Window` scene with a content that ignores any safe area and puts a window reference
    /// into the environment.
    public var body: some Scene {
        Window(self.titleKey, id: self.id) {
            self.content()
                .ignoresSafeArea()
                .framelessWindow(self.$window)
        }.windowStyle(.hiddenTitleBar)
            .onChange(of: self.scenePhase, perform: self.adaptWindowToScenePhase(_:))
    }

    /**
     Initialize a new FramelessWindow Scene.
     
     - Parameters:
       - id: A unique string identifier that you can use to open the window.
       - titleKey: A localized string key to use for the window’s title in system menus and in the
                   window’s title bar. Provide a title that describes the purpose of the window. As
                   a frameless window does not have a title bar and does not appear in the application
                   window menu, this value has no effect. Default value is `"Launcher"`.
       - content: The view content to display in the window.
     */
    public init(withId id: String, andTitle titleKey: LocalizedStringKey = "Launcher", @ViewBuilder content: @escaping () -> Content) {
        self.titleKey = titleKey
        self.id = id
        self.content = content
    }

    /// Make window frameless on active states and remove it from environment on background state.
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

    /// Adds window to enviroment by assigning to own state variable.
    private func addWindowToEnvironment(_ window: NSWindow) {
        self.window = window
    }

    /// Remove window from enviroment by assigning nil to own state variable.
    private func removeWindowFromEnvironment() {
        self.window = nil
    }

    /// Hide the miniaturize and zoom default window buttons and remove the window from the application window menu.
    private func modify(window: NSWindow) {
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.isExcludedFromWindowsMenu = true
    }

    /// Return the window with the matching identifier from all windows of the current application.
    private func getWindowById() -> NSWindow? {
        for window in NSApplication.shared.windows {
            guard window.identifier?.rawValue == self.id else { continue }
            return window
        }
        return nil
    }
}
