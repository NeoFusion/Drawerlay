import AppKit

protocol PanelProtocol {
    func enable()
    func disable()
    func activate()
    func deactivate()
    func clear()
    func setColor(_ color: NSColor)
    func setLineWidth(_ lineWidth: CGFloat)
    func setTimeout(_ timeout: TimeInterval)
}
