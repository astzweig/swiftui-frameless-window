import SwiftUI

private struct FramelessWindowEnvironmentKey: EnvironmentKey {
    static let defaultValue: Binding<NSWindow?> = .constant(nil)
}

public extension EnvironmentValues {
    var framelessWindow: Binding<NSWindow?> {
        get { self[FramelessWindowEnvironmentKey.self] }
        set { self[FramelessWindowEnvironmentKey.self] = newValue }
    }
}

public extension View {
    func framelessWindow(_ window: Binding<NSWindow?>) -> some View {
        self.environment(\.framelessWindow, window)
    }
}
