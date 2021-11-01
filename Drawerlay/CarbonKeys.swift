import Carbon

struct CarbonKeys {
    static func getKey(_ keyCode: UInt32) -> String {
        switch keyCode {
        case UInt32(kVK_ANSI_A): return "A"
        case UInt32(kVK_ANSI_S): return "S"
        case UInt32(kVK_ANSI_D): return "D"
        case UInt32(kVK_ANSI_F): return "F"
        case UInt32(kVK_ANSI_H): return "H"
        case UInt32(kVK_ANSI_G): return "G"
        case UInt32(kVK_ANSI_Z): return "Z"
        case UInt32(kVK_ANSI_X): return "X"
        case UInt32(kVK_ANSI_C): return "C"
        case UInt32(kVK_ANSI_V): return "V"
        case UInt32(kVK_ANSI_B): return "B"
        case UInt32(kVK_ANSI_Q): return "Q"
        case UInt32(kVK_ANSI_W): return "W"
        case UInt32(kVK_ANSI_E): return "E"
        case UInt32(kVK_ANSI_R): return "R"
        case UInt32(kVK_ANSI_Y): return "Y"
        case UInt32(kVK_ANSI_T): return "T"
        case UInt32(kVK_ANSI_1): return "1"
        case UInt32(kVK_ANSI_2): return "2"
        case UInt32(kVK_ANSI_3): return "3"
        case UInt32(kVK_ANSI_4): return "4"
        case UInt32(kVK_ANSI_6): return "6"
        case UInt32(kVK_ANSI_5): return "5"
        case UInt32(kVK_ANSI_Equal): return "="
        case UInt32(kVK_ANSI_9): return "9"
        case UInt32(kVK_ANSI_7): return "7"
        case UInt32(kVK_ANSI_Minus): return "-"
        case UInt32(kVK_ANSI_8): return "8"
        case UInt32(kVK_ANSI_0): return "0"
        case UInt32(kVK_ANSI_RightBracket): return "]"
        case UInt32(kVK_ANSI_O): return "O"
        case UInt32(kVK_ANSI_U): return "U"
        case UInt32(kVK_ANSI_LeftBracket): return "["
        case UInt32(kVK_ANSI_I): return "I"
        case UInt32(kVK_ANSI_P): return "P"
        case UInt32(kVK_ANSI_L): return "L"
        case UInt32(kVK_ANSI_J): return "J"
        case UInt32(kVK_ANSI_Quote): return "'"
        case UInt32(kVK_ANSI_K): return "K"
        case UInt32(kVK_ANSI_Semicolon): return ";"
        case UInt32(kVK_ANSI_Backslash): return "\\"
        case UInt32(kVK_ANSI_Comma): return ","
        case UInt32(kVK_ANSI_Slash): return "/"
        case UInt32(kVK_ANSI_N): return "N"
        case UInt32(kVK_ANSI_M): return "M"
        case UInt32(kVK_ANSI_Period): return "."
        case UInt32(kVK_ANSI_Grave): return "`"
        case UInt32(kVK_ANSI_KeypadDecimal): return ","
        case UInt32(kVK_ANSI_KeypadMultiply): return "*"
        case UInt32(kVK_ANSI_KeypadPlus): return "+"
        case UInt32(kVK_ANSI_KeypadClear): return "⌧"
        case UInt32(kVK_ANSI_KeypadDivide): return "/"
        case UInt32(kVK_ANSI_KeypadEnter): return "⌅"
        case UInt32(kVK_ANSI_KeypadMinus): return "-"
        case UInt32(kVK_ANSI_KeypadEquals): return "="
        case UInt32(kVK_ANSI_Keypad0): return "0"
        case UInt32(kVK_ANSI_Keypad1): return "1"
        case UInt32(kVK_ANSI_Keypad2): return "2"
        case UInt32(kVK_ANSI_Keypad3): return "3"
        case UInt32(kVK_ANSI_Keypad4): return "4"
        case UInt32(kVK_ANSI_Keypad5): return "5"
        case UInt32(kVK_ANSI_Keypad6): return "6"
        case UInt32(kVK_ANSI_Keypad7): return "7"
        case UInt32(kVK_ANSI_Keypad8): return "8"
        case UInt32(kVK_ANSI_Keypad9): return "9"
        case UInt32(kVK_Return): return "⏎"
        case UInt32(kVK_Space): return "␣"
        case UInt32(kVK_Delete): return "⌫"
        case UInt32(kVK_F17): return "F17"
        case UInt32(kVK_F18): return "F18"
        case UInt32(kVK_F19): return "F19"
        case UInt32(kVK_F20): return "F20"
        case UInt32(kVK_F5): return "F5"
        case UInt32(kVK_F6): return "F6"
        case UInt32(kVK_F7): return "F7"
        case UInt32(kVK_F3): return "F3"
        case UInt32(kVK_F8): return "F8"
        case UInt32(kVK_F9): return "F9"
        case UInt32(kVK_F11): return "F11"
        case UInt32(kVK_F13): return "F13"
        case UInt32(kVK_F16): return "F16"
        case UInt32(kVK_F14): return "F14"
        case UInt32(kVK_F10): return "F10"
        case UInt32(kVK_F12): return "F12"
        case UInt32(kVK_F15): return "F15"
        case UInt32(kVK_Home): return "⇱"
        case UInt32(kVK_PageUp): return "⇞"
        case UInt32(kVK_ForwardDelete): return "⌦"
        case UInt32(kVK_F4): return "F4"
        case UInt32(kVK_End): return "⇲"
        case UInt32(kVK_F2): return "F2"
        case UInt32(kVK_PageDown): return "⇟"
        case UInt32(kVK_F1): return "F1"
        case UInt32(kVK_LeftArrow): return "←"
        case UInt32(kVK_RightArrow): return "→"
        case UInt32(kVK_DownArrow): return "↓"
        case UInt32(kVK_UpArrow): return "↑"
        case UInt32(kVK_ISO_Section): return "§"
        default:
            return ""
        }
    }

    static func addCmdKey(_ code: UInt32) -> UInt32 {
        code | UInt32(cmdKey)
    }

    static func addOptionKey(_ code: UInt32) -> UInt32 {
        code | UInt32(optionKey)
    }

    static func addControlKey(_ code: UInt32) -> UInt32 {
        code | UInt32(controlKey)
    }

    static func addShiftKey(_ code: UInt32) -> UInt32 {
        code | UInt32(shiftKey)
    }

    static func getKeyModifiers(_ keyModifiers: UInt32) -> String {
        var string = ""
        if keyModifiers & UInt32(controlKey) == UInt32(controlKey) {
            string += "⌃"
        }
        if keyModifiers & UInt32(optionKey) == UInt32(optionKey) {
            string += "⌥"
        }
        if keyModifiers & UInt32(shiftKey) == UInt32(shiftKey) {
            string += "⇧"
        }
        if keyModifiers & UInt32(cmdKey) == UInt32(cmdKey) {
            string += "⌘"
        }
        return string
    }
}
