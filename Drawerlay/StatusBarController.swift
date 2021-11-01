import AppKit

class StatusBarController {
    private let statusBar: NSStatusBar
    private let statusBarItem: NSStatusItem
    private let stateMenuItem: NSMenuItem
    private let hotKeyInfoMenu: NSMenuItem
    private let colorMenu: NSMenu
    private let lineWidthMenu: NSMenu
    private let timeoutMenu: NSMenu

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
        hotKeyInfoMenu = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        hotKeyInfoMenu.isHidden = true
        statusBarMenu.addItem(hotKeyInfoMenu)
        statusBarMenu.addItem(NSMenuItem(title: "Change…", action: #selector(AppDelegate.showChangeHotkeyWindow), keyEquivalent: ""))
        statusBarMenu.addItem(NSMenuItem.separator())

        colorMenu = NSMenu()
        for (title, value) in Parameters.colors {
            let menuItem = ParamMenuItem(title: title, action: #selector(AppDelegate.colorSelector), keyEquivalent: "")
            menuItem.param = value
            colorMenu.addItem(menuItem)
        }
        let colorMenuItem = NSMenuItem(title: "Color", action: nil, keyEquivalent: "")
        colorMenuItem.submenu = colorMenu
        statusBarMenu.addItem(colorMenuItem)

        lineWidthMenu = NSMenu()
        for (title, value) in Parameters.lineWidths {
            let menuItem = ParamMenuItem(title: title, action: #selector(AppDelegate.lineWidthSelector), keyEquivalent: "")
            menuItem.param = value
            lineWidthMenu.addItem(menuItem)
        }
        let lineWidthMenuItem = NSMenuItem(title: "Line width", action: nil, keyEquivalent: "")
        lineWidthMenuItem.submenu = lineWidthMenu
        statusBarMenu.addItem(lineWidthMenuItem)

        timeoutMenu = NSMenu()
        for (title, value) in Parameters.timeouts {
            let menuItem = ParamMenuItem(title: title, action: #selector(AppDelegate.timeoutSelector), keyEquivalent: "")
            menuItem.param = value
            timeoutMenu.addItem(menuItem)
        }
        let timeoutMenuItem = NSMenuItem(title: "Timeout", action: nil, keyEquivalent: "")
        timeoutMenuItem.submenu = timeoutMenu
        statusBarMenu.addItem(timeoutMenuItem)

        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(withTitle: "About", action: #selector(AppDelegate.showAboutWindow), keyEquivalent: "")
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(withTitle: "Quit", action: #selector(NSApp.terminate), keyEquivalent: "")
        statusBarItem.menu = statusBarMenu
    }

    func setEnabledState() {
        stateMenuItem.title = "Disable"
        stateMenuItem.setStateOn()
    }

    func setDisabledState() {
        stateMenuItem.title = "Enable"
        stateMenuItem.setStateOff()
    }

    func setHotKeyInfo(_ hotKey: String) {
        hotKeyInfoMenu.title = "Draw hotkey: " + hotKey
        hotKeyInfoMenu.isHidden = false
    }

    func setActiveColor(item: NSMenuItem) {
        for menuItem in colorMenu.items {
            if menuItem == item {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }

    func setActiveColor(color: NSColor) {
        for menuItem in colorMenu.items as! [ParamMenuItem] {
            if menuItem.param as! NSColor == color {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }

    func setActiveLineWidth(item: NSMenuItem) {
        for menuItem in lineWidthMenu.items {
            if menuItem == item {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }

    func setActiveLineWidth(lineWidth: CGFloat) {
        for menuItem in lineWidthMenu.items as! [ParamMenuItem] {
            if menuItem.param as! CGFloat == lineWidth {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }

    func setActiveTimeout(item: NSMenuItem) {
        for menuItem in timeoutMenu.items {
            if menuItem == item {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }

    func setActiveTimeout(timeout: TimeInterval) {
        for menuItem in timeoutMenu.items as! [ParamMenuItem] {
            if menuItem.param as! TimeInterval == timeout {
                menuItem.setStateOn()
            } else {
                menuItem.setStateOff()
            }
        }
    }
}

extension NSMenuItem {
    func setStateOn() {
        state = NSControl.StateValue.on
    }

    func setStateOff() {
        state = NSControl.StateValue.off
    }
}
