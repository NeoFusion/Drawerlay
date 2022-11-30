import Carbon
import os.log

final class HotKeyManager {
    private static let hotKeyID = EventHotKeyID(
            signature: 0x4452574C, // DRWL
            id: 0
    )

    private static var hotKey = HotKey(code: 0, modifiers: 0)

    private static var eventHotKey: EventHotKeyRef?
    private static var eventHandler: EventHandlerRef?

    private static var onKeyPressed: Handler?
    private static var onKeyReleased: Handler?

    private static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "hotKey")

    typealias Handler = () -> Void

    static func registerHandlers(onKeyPressed: @escaping Handler, onKeyReleased: @escaping Handler) {
        self.onKeyPressed = onKeyPressed
        self.onKeyReleased = onKeyReleased
    }

    static func setHotKey(_ hotKey: HotKey) {
        HotKeyManager.hotKey = hotKey
    }

    static func registerHotKey() {
        let error = RegisterEventHotKey(
                hotKey.code,
                hotKey.modifiers,
                hotKeyID,
                GetEventDispatcherTarget(),
                0,
                &eventHotKey
        )
        guard error == noErr, eventHotKey != nil else {
            os_log("RegisterEventHotKey error", log: log, type: .error)
            return
        }
    }

    static func installEventHandler() {
        let list = [
            EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed)),
            EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyReleased)),
        ]
        let error = InstallEventHandler(
                GetEventDispatcherTarget(),
                hotKeyEventHandler,
                list.count,
                list,
                nil,
                &eventHandler
        )
        guard error == noErr, eventHandler != nil else {
            os_log("InstallEventHandler error", log: log, type: .error)
            return
        }
    }

    static func removeEventHandler() {
        if eventHandler != nil {
            if RemoveEventHandler(eventHandler) != noErr {
                os_log("RemoveEventHandler error", log: log, type: .error)
            }
        }
    }

    static func unregisterHotKey() {
        if eventHotKey != nil {
            if UnregisterEventHotKey(eventHotKey) != noErr {
                os_log("UnregisterEventHotKey error", log: log, type: .error)
            }
        }
    }

    static func handleEvent(event: EventRef?) -> OSStatus {
        var hotKeyID = EventHotKeyID()
        let error = GetEventParameter(
                event,
                EventParamName(kEventParamDirectObject),
                EventParamType(typeEventHotKeyID),
                nil,
                MemoryLayout<EventHotKeyID>.size,
                nil,
                &hotKeyID
        )
        if error != noErr {
            return error
        }
        guard hotKeyID.signature == self.hotKeyID.signature, hotKeyID.id == self.hotKeyID.id else {
            return OSStatus(eventNotHandledErr)
        }
        switch GetEventKind(event) {
        case UInt32(kEventHotKeyPressed):
            if let onKeyPressed = onKeyPressed {
                onKeyPressed()
            }
        case UInt32(kEventHotKeyReleased):
            if let onKeyReleased = onKeyReleased {
                onKeyReleased()
            }
        default:
            break
        }
        return noErr
    }
}

func hotKeyEventHandler(eventHandlerCall: EventHandlerCallRef?, event: EventRef?, data: UnsafeMutableRawPointer?) -> OSStatus {
    HotKeyManager.handleEvent(event: event)
}
