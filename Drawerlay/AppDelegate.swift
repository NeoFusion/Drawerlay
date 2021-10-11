import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarController: StatusBarController!
    private var panelController: PanelController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarController = StatusBarController()
        panelController = PanelController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    @objc func togglePanel() {
        if panelController.isActive() {
            panelController.disable()
            statusBarController.setDisabledState()
        } else {
            panelController.enable()
            statusBarController.setEnabledState()
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
