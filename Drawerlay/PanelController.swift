import AppKit

class PanelController: PanelProtocol {
    private let panel: NSPanel

    init(_ screen: NSScreen, _ parameters: PanelParameters) {
        panel = NSPanel(
                contentRect: NSMakeRect(0, 0, 0, 0),
                styleMask: [.borderless, .nonactivatingPanel],
                backing: .buffered,
                defer: false,
                screen: screen
        )
        panel.level = .mainMenu
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.backgroundColor = NSColor.clear
        panel.ignoresMouseEvents = true
        panel.contentViewController = DrawViewController()
        setColor(parameters.color)
        setLineWidth(parameters.lineWidth)
        setTimeout(parameters.timeout)
    }

    func enable() {
        panel.orderFrontRegardless()
    }

    func disable() {
        panel.ignoresMouseEvents = true
        panel.close()
    }

    func activate() {
        panel.ignoresMouseEvents = false
    }

    func deactivate() {
        panel.ignoresMouseEvents = true
    }

    func clear() {
        if let viewController = panel.contentViewController as? DrawViewController {
            viewController.clear()
        }
    }

    func setColor(_ color: NSColor) {
        if let viewController = panel.contentViewController as? DrawViewController {
            viewController.setColor(color)
        }
    }

    func setLineWidth(_ lineWidth: CGFloat) {
        if let viewController = panel.contentViewController as? DrawViewController {
            viewController.setLineWidth(lineWidth)
        }
    }

    func setTimeout(_ timeout: TimeInterval) {
        if let viewController = panel.contentViewController as? DrawViewController {
            viewController.setTimeout(timeout)
        }
    }
}
