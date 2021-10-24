import AppKit

struct Parameters {
    static let colors: KeyValuePairs<String, NSColor> = [
        "Black": NSColor.black,
        "Green": NSColor.green,
        "Red": NSColor.red,
    ]
    static let colorKey = "color"
    static let defaultColor = NSColor.red
    static let defaultColorName = "Red"

    static let lineWidths: KeyValuePairs<String, CGFloat> = [
        "5": 5,
        "10": 10,
    ]
    static let lineWidthKey = "lineWidth"
    static let defaultLineWidth: CGFloat = 5

    static let timeouts: KeyValuePairs<String, TimeInterval> = [
        "3s": 3,
        "5s": 5,
        "10s": 10,
        "Disabled": 0,
    ]
    static let timeoutKey = "timeout"
    static let defaultTimeout: TimeInterval = 5
}
