import AppKit

class ScreenController: PanelProtocol {
    private var panels: [Int: PanelController] = [:]
    private var enabled = false
    private var parameters: PanelParameters

    init(_ parameters: PanelParameters) {
        self.parameters = parameters
        for screen in NSScreen.screens {
            panels[screen.hash] = PanelController(screen, parameters)
        }
        NotificationCenter.default.addObserver(
                forName: NSApplication.didChangeScreenParametersNotification,
                object: NSApplication.shared,
                queue: OperationQueue.main,
                using: screenChanged
        )
    }

    func screenChanged(notification: Notification) {
        for panel in panels.values {
            panel.disable()
        }
        panels = [:]
        for screen in NSScreen.screens {
            let panel = PanelController(screen, parameters)
            panels[screen.hash] = panel
            if enabled {
                panel.enable()
            }
        }
    }

    func enable() {
        enabled = true
        for panel in panels.values {
            panel.enable()
        }
    }

    func disable() {
        enabled = false
        for panel in panels.values {
            panel.disable()
        }
    }

    func activate() {
        for panel in panels.values {
            panel.activate()
        }
    }

    func deactivate() {
        for panel in panels.values {
            panel.deactivate()
        }
    }

    func clear() {
        for panel in panels.values {
            panel.clear()
        }
    }

    func setColor(_ color: NSColor) {
        parameters.color = color
        for panel in panels.values {
            panel.setColor(color)
        }
    }

    func setLineWidth(_ lineWidth: CGFloat) {
        parameters.lineWidth = lineWidth
        for panel in panels.values {
            panel.setLineWidth(lineWidth)
        }
    }

    func setTimeout(_ timeout: TimeInterval) {
        parameters.timeout = timeout
        for panel in panels.values {
            panel.setTimeout(timeout)
        }
    }
}
