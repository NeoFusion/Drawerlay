import AppKit

class DrawView: NSView {
    private let path: NSBezierPath = { () -> NSBezierPath in
        let path = NSBezierPath()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = Parameters.defaultLineWidth
        return path
    }()
    private var color: NSColor = Parameters.defaultColor
    private var timeInterval: TimeInterval = Parameters.defaultTimeout
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
        if timeInterval != 0 {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        color.set()
        path.stroke()
    }

    @objc func clear() {
        path.removeAllPoints()
        needsDisplay = true
    }

    func setColor(_ color: NSColor) {
        self.color = color
    }

    func setLineWidth(_ lineWidth: CGFloat) {
        path.lineWidth = lineWidth
    }

    func setTimeout(_ timeout: TimeInterval) {
        timeInterval = timeout
    }
}
