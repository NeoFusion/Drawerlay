import AppKit

struct Parameters {
    static let colors: KeyValuePairs<String, NSColor> = [
        "Black": NSColor.black,
        "Green": NSColor.green,
        "Red": NSColor.red,
    ]
    static let defaultColor = NSColor.red

    static let lineWidths: KeyValuePairs<String, CGFloat> = [
        "5": 5,
        "10": 10,
    ]
    static let defaultLineWidth: CGFloat = 5

    static let timeouts: KeyValuePairs<String, TimeInterval> = [
        "3s": 3,
        "5s": 5,
        "10s": 10,
        "Disabled": 0,
    ]
    static let defaultTimeout: TimeInterval = 5
}
