import AppKit

class DrawViewController: NSViewController {
    override func loadView() {
        view = DrawView(frame: NSRect(x: 0, y: 0, width: NSScreen.main?.frame.width ?? 100, height: NSScreen.main?.frame.height ?? 100))
    }

    func clear() {
        if let view = view as? DrawView {
            view.clear()
        }
    }
}
