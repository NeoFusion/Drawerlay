import AppKit

class HotKeyViewController: NSViewController {
    private let textField = NSTextField(frame: NSRect(x: 20, y: 20, width: 96, height: 21))
    var listening = false
    var onHotKeyUpdate: ((HotKey) -> Void)?

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 216, height: 61))

        textField.isEditable = false
        textField.alignment = NSTextAlignment.center
        view.addSubview(textField)

        let button = NSButton(frame: NSRect(x: 115, y: 13, width: 87, height: 32))
        button.title = "Change"
        button.action = #selector(onClickButton)
        button.bezelStyle = NSButton.BezelStyle.rounded
        view.addSubview(button)
    }

    @objc private func onClickButton() {
        listening = true
        view.window?.makeFirstResponder(nil)
    }

    func setHotKeyTextField(_ hotKey: String) {
        textField.stringValue = hotKey
    }

    func updateHotKey(keyCode: UInt16, flags: NSEvent.ModifierFlags) {
        let keyModifiers = getKeyModifiers(flags)
        setHotKeyTextField(keyModifiers.string + CarbonKeys.getKey(UInt32(keyCode)))
        onHotKeyUpdate?(HotKey(code: UInt32(keyCode), modifiers: keyModifiers.code))
    }

    func getKeyModifiers(_ flags: NSEvent.ModifierFlags) -> (string: String, code: UInt32) {
        var string = ""
        var code: UInt32 = 0
        if flags.contains(.control) {
            string += "⌃"
            code = CarbonKeys.addControlKey(code)
        }
        if flags.contains(.option) {
            string += "⌥"
            code = CarbonKeys.addOptionKey(code)
        }
        if flags.contains(.shift) {
            string += "⇧"
            code = CarbonKeys.addShiftKey(code)
        }
        if flags.contains(.command) {
            string += "⌘"
            code = CarbonKeys.addCmdKey(code)
        }
        return (string, code)
    }
}
