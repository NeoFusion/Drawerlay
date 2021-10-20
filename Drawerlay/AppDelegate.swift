import AppKit
import Carbon

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarController: StatusBarController!
    private var panelController: PanelController!
    private var active = false

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarController = StatusBarController()
        panelController = PanelController()
        HotKeyManager.registerHandlers(
                onKeyPressed: panelController.activate,
                onKeyReleased: panelController.deactivate
        )
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        if active {
            deactivateHotKey()
        }
    }

    private func activateHotKey() {
        HotKeyManager.registerHotKey(hotKeyCode: UInt32(kVK_ISO_Section), hotKeyModifiers: UInt32(cmdKey))
        HotKeyManager.installEventHandler()
    }

    private func deactivateHotKey() {
        HotKeyManager.removeEventHandler()
        HotKeyManager.unregisterHotKey()
    }

    @objc func togglePanel() {
        if active {
            deactivateHotKey()
            panelController.clear()
            panelController.disable()
            statusBarController.setDisabledState()
            active = false
        } else {
            panelController.enable()
            activateHotKey()
            statusBarController.setEnabledState()
            active = true
        }
    }

    @objc func clear() {
        panelController.clear()
    }

    @objc func showAboutWindow() {
        NSApp.orderFrontStandardAboutPanel()
        NSApp.activate(ignoringOtherApps: true)
    }
}
