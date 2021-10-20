import AppKit

class PanelController {
    private let panel: NSPanel

    init() {
        panel = NSPanel(
                contentRect: NSMakeRect(0, 0, 0, 0),
                styleMask: [.borderless, .nonactivatingPanel],
                backing: .buffered,
                defer: false
        )
        panel.level = .mainMenu
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.backgroundColor = NSColor.clear
        panel.ignoresMouseEvents = true
        panel.contentViewController = DrawViewController()
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
}
