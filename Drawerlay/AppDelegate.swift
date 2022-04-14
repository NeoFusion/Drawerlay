import AppKit
import Carbon

class AppDelegate: NSObject, NSApplicationDelegate {
    private let defaults = UserDefaults.standard
    private var statusBarController: StatusBarController!
    private var screenController: ScreenController!
    private var active = false
    private var currentParams: Dictionary = [String:Any]()
    private var hotKeyWindowController: HotKeyWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarController = StatusBarController()
        let parameters = loadUserDefaults()
        screenController = ScreenController(parameters)
        HotKeyManager.registerHandlers(
                onKeyPressed: screenController.activate,
                onKeyReleased: screenController.deactivate
        )
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        if active {
            deactivateHotKey()
        }
        saveUserDefaults()
    }

    private func loadUserDefaults() -> PanelParameters {
        var parameters = PanelParameters(
                color: Parameters.defaultColor,
                lineWidth: Parameters.defaultLineWidth,
                timeout: Parameters.defaultTimeout
        )
        if let hotKeyCode = defaults.value(forKey: Parameters.hotKeyCodeKey) as? UInt32,
           let hotKeyModifiers = defaults.value(forKey: Parameters.hotKeyModifiersKey) as? UInt32
        {
            setHotKey(HotKey(code: hotKeyCode, modifiers: hotKeyModifiers))
        } else {
            defaults.set(Parameters.defaultHotKey.code, forKey: Parameters.hotKeyCodeKey)
            defaults.set(Parameters.defaultHotKey.modifiers, forKey: Parameters.hotKeyModifiersKey)
            setHotKey(Parameters.defaultHotKey)
        }
        if let colorName = defaults.value(forKey: Parameters.colorKey) as? String,
           let colorIndex = Parameters.colors.firstIndex(where: { $0.key == colorName })
        {
            let color = Parameters.colors[colorIndex].value
            currentParams[Parameters.colorKey] = colorName
            parameters.color = color
            statusBarController.setActiveColor(color: color)
        } else {
            defaults.set(Parameters.defaultColorName, forKey: Parameters.colorKey)
            currentParams[Parameters.colorKey] = Parameters.defaultColorName
            statusBarController.setActiveColor(color: Parameters.defaultColor)
        }
        if let lineWidth = defaults.value(forKey: Parameters.lineWidthKey) as? CGFloat {
            currentParams[Parameters.lineWidthKey] = lineWidth
            parameters.lineWidth = lineWidth
            statusBarController.setActiveLineWidth(lineWidth: lineWidth)
        } else {
            defaults.set(Parameters.defaultLineWidth, forKey: Parameters.lineWidthKey)
            currentParams[Parameters.lineWidthKey] = Parameters.defaultLineWidth
            statusBarController.setActiveLineWidth(lineWidth: Parameters.defaultLineWidth)
        }
        if let timeout = defaults.value(forKey: Parameters.timeoutKey) as? TimeInterval {
            currentParams[Parameters.timeoutKey] = timeout
            parameters.timeout = timeout
            statusBarController.setActiveTimeout(timeout: timeout)
        } else {
            defaults.set(Parameters.defaultTimeout, forKey: "timeout")
            currentParams[Parameters.timeoutKey] = Parameters.defaultTimeout
            statusBarController.setActiveTimeout(timeout: Parameters.defaultTimeout)
        }
        return parameters
    }

    private func saveUserDefaults() {
        for (key, value) in currentParams {
            defaults.set(value, forKey: key)
        }
    }

    private func setHotKey(_ hotKey: HotKey) {
        currentParams[Parameters.hotKeyCodeKey] = hotKey.code
        currentParams[Parameters.hotKeyModifiersKey] = hotKey.modifiers
        statusBarController.setHotKeyInfo(
                CarbonKeys.getKeyModifiers(hotKey.modifiers) + CarbonKeys.getKey(hotKey.code)
        )
        HotKeyManager.setHotKey(hotKey)
    }

    private func activateHotKey() {
        HotKeyManager.registerHotKey()
        HotKeyManager.installEventHandler()
    }

    private func deactivateHotKey() {
        HotKeyManager.removeEventHandler()
        HotKeyManager.unregisterHotKey()
    }

    @objc func togglePanel() {
        if active {
            deactivateHotKey()
            screenController.clear()
            screenController.disable()
            statusBarController.setDisabledState()
            active = false
        } else {
            screenController.enable()
            activateHotKey()
            statusBarController.setEnabledState()
            active = true
        }
    }

    @objc func clear() {
        screenController.clear()
    }

    @objc func colorSelector(sender: ParamMenuItem) {
        if let color = sender.param as? NSColor,
           let colorIndex = Parameters.colors.firstIndex(where: { $0.value == color })
        {
            let colorName = Parameters.colors[colorIndex].key
            currentParams[Parameters.colorKey] = colorName
            screenController.setColor(color)
            statusBarController.setActiveColor(item: sender)
        }
    }

    @objc func lineWidthSelector(sender: ParamMenuItem) {
        if let lineWidth = sender.param as? CGFloat {
            currentParams[Parameters.lineWidthKey] = lineWidth
            screenController.setLineWidth(lineWidth)
            statusBarController.setActiveLineWidth(item: sender)
        }
    }

    @objc func timeoutSelector(sender: ParamMenuItem) {
        if let timeout = sender.param as? TimeInterval {
            currentParams[Parameters.timeoutKey] = timeout
            screenController.setTimeout(timeout)
            statusBarController.setActiveTimeout(item: sender)
        }
    }

    @objc func showAboutWindow() {
        NSApp.orderFrontStandardAboutPanel()
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func showChangeHotkeyWindow() {
        if hotKeyWindowController == nil {
            let window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 250, height: 150),
                    styleMask: [.titled, .closable],
                    backing: .buffered,
                    defer: false
            )
            window.center()
            let hotKeyViewController = HotKeyViewController()
            hotKeyViewController.setHotKeyTextField(
                    CarbonKeys.getKeyModifiers(currentParams[Parameters.hotKeyModifiersKey] as! UInt32)
                            + CarbonKeys.getKey(currentParams[Parameters.hotKeyCodeKey] as! UInt32)
            )
            hotKeyViewController.onHotKeyUpdate = setHotKey
            window.contentViewController = hotKeyViewController
            hotKeyWindowController = HotKeyWindowController(window: window)
            window.delegate = hotKeyWindowController
        }
        hotKeyWindowController?.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
