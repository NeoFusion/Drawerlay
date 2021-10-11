import AppKit

class DrawView: NSView {
    private let path: NSBezierPath = NSBezierPath()
    private var timer: Timer?

    override func mouseDown(with event: NSEvent) {
        timer?.invalidate()
        path.move(to: convert(event.locationInWindow, from: nil))
        needsDisplay = true
    }

    override func mouseDragged(with event: NSEvent) {
        path.line(to: convert(event.locationInWindow, from: nil))
        needsDisplay = true
    }

    override func mouseUp(with event: NSEvent) {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: .common)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.red.set()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = 5.0
        path.stroke()
    }

    @objc func clear() {
        path.removeAllPoints()
        needsDisplay = true
    }
}
