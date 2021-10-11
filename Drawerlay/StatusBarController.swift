import AppKit

class StatusBarController {
    private let statusBar: NSStatusBar
    private let statusBarItem: NSStatusItem
    private let stateMenuItem: NSMenuItem

    init() {
        statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "🌀"
        let statusBarMenu = NSMenu(title: "Drawerlay")
        stateMenuItem = NSMenuItem(title: "Enable", action: #selector(AppDelegate.togglePanel), keyEquivalent: "")
        statusBarMenu.addItem(stateMenuItem)
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(NSMenuItem(title: "Clear", action: #selector(AppDelegate.clear), keyEquivalent: ""))
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(withTitle: "About", action: #selector(AppDelegate.showAboutWindow), keyEquivalent: "")
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(withTitle: "Quit", action: #selector(NSApp.terminate), keyEquivalent: "")
        statusBarItem.menu = statusBarMenu
    }

    func setEnabledState() {
        stateMenuItem.title = "Disable"
        stateMenuItem.state = NSControl.StateValue.on
    }

    func setDisabledState() {
        stateMenuItem.title = "Enable"
        stateMenuItem.state = NSControl.StateValue.off
    }
}
