import SwiftUI

/// The internal storage environment key for the frameless window.
private struct FramelessWindowEnvironmentKey: EnvironmentKey {
	static let defaultValue: Binding<NSWindow?> = .constant(nil)
}

/// The environment key for accessing the frameless window.
public extension EnvironmentValues {
	var framelessWindow: Binding<NSWindow?> {
		get { self[FramelessWindowEnvironmentKey.self] }
		set { self[FramelessWindowEnvironmentKey.self] = newValue }
	}
}

/// The view modifier for more concise write access to the framelessWindow environment value.
public extension View {
	func framelessWindow(_ window: Binding<NSWindow?>) -> some View {
		self.environment(\.framelessWindow, window)
	}
}
