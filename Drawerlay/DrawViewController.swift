import AppKit

class DrawViewController: NSViewController {
    override func loadView() {
        view = DrawView(frame: NSRect(x: 0, y: 0, width: NSScreen.main?.frame.width ?? 100, height: NSScreen.main?.frame.height ?? 100))
    }

    func setColor(_ color: NSColor) {
        if let view = view as? DrawView {
            view.setColor(color)
        }
    }

    func setLineWidth(_ lineWidth: CGFloat) {
        if let view = view as? DrawView {
            view.setLineWidth(lineWidth)
        }
    }

    func setTimeout(_ timeout: TimeInterval) {
        if let view = view as? DrawView {
            view.setTimeout(timeout)
        }
    }

    func clear() {
        if let view = view as? DrawView {
            view.clear()
        }
    }
}
