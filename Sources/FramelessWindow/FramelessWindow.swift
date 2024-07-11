import SwiftUI
import WindowReference

/**
 A SwiftUI scene that creates a bare single window without the included default items.

 A frameless window does not include a title bar and neither the minimize nor the zoom
 default window buttons. Additionally it is excluded from the applications window menu.
 */
public struct FramelessWindow<Content: View>: Scene {
	let titleKey: LocalizedStringKey
	let id: String
	let content: () -> Content

	/// A `Window` scene with a content that ignores any safe area and puts a window reference
	/// into the environment.
	public var body: some Scene {
		Window(self.titleKey, id: self.id) {
			WindowReference(withId: self.id, andWindowInitializer: self.modify(window:)) {
				self.content()
			}.ignoresSafeArea()
		}.windowStyle(.hiddenTitleBar)
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
	public init(_ title: LocalizedStringKey = "Launcher", id: String, @ViewBuilder content: @escaping () -> Content) {
		self.titleKey = title
		self.id = id
		self.content = content
	}

	/// Hide the miniaturize and zoom default window buttons and remove the window from the application window menu.
	private func modify(window: NSWindow) {
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true
		window.isExcludedFromWindowsMenu = true
	}
}
