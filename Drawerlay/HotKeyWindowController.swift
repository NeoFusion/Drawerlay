import AppKit

class HotKeyWindowController: NSWindowController, NSWindowDelegate {
    override func keyDown(with event: NSEvent) {
        if let controller = contentViewController as? HotKeyViewController {
            if controller.listening {
                controller.listening = false
                controller.updateHotKey(
                        keyCode: event.keyCode,
                        flags: event.modifierFlags
                )
            }
        }
    }

    func windowDidResignKey(_ notification: Notification) {
        if let controller = contentViewController as? HotKeyViewController {
            controller.listening = false
        }
    }
}
