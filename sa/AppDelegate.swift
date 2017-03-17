//
//  AppDelegate.swift
//  sa
//
//  Created by Yushi Nakai on 3/15/17.
//  Copyright © 2017 isasaka. All rights reserved.
//

import Cocoa
import Magnet
import KeyHolder

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let sa = Sa()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.statusItem.title = "Sa"
        self.statusItem.highlightMode = true
        self.statusItem.menu = NSMenu()
        
        let quitItem = NSMenuItem()
        quitItem.title = "Quit Application"
        quitItem.action = #selector(AppDelegate.quit(_:))
        self.statusItem.menu?.addItem(quitItem)
        
        // http://stackoverflow.com/questions/3202629/where-can-i-find-a-list-of-mac-virtual-key-codes
        
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.T, mods: [.command, .control], app: "iTerm2"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.C, mods: [.command, .control], app: "Google Chrome"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.H, mods: [.command, .control], app: "HipChat"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.M, mods: [.command, .control], app: "MatterMost"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.S, mods: [.command, .control], app: "Slack"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.E, mods: [.command, .control], app: "Visual Studio Code"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.V, mods: [.command, .control], app: "Vmware Fusion"))
        sa.registerEvent(ev: SaOpenApplicationEvent(keyCode: Key.X, mods: [.command, .control], app: "Xcode"))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func quit(_ sender: Any){
        //アプリケーションの終了
        NSApplication.shared().terminate(self)
    }
    func handler(_ sender: Any){
        let hotkey = sender as! HotKey
        print(hotkey.identifier)
    }
}



class Sa {
    var events: [String: SaEvent] = [:]
    func registerEvent(ev: SaEvent){
        ev.registerKey()
    }
}

class SaEvent: NSObject {
    let keyCombo: KeyCombo
    init(keyCode: Key,mods: NSEventModifierFlags){
        keyCombo = KeyCombo(keyCode: keyCode.rawValue, cocoaModifiers: mods)!
    }
    func registerKey(){
        let hotKey = HotKey(identifier: "\(keyCombo.keyCode)", keyCombo: keyCombo, target: self, action: #selector(handler(_:)))
        if !hotKey.register(){
            print("failed to register event")
        }
    }
    @objc func handler(_ sender: Any){
        print("hey")
    }
}

class SaOpenApplicationEvent: SaEvent {
    let appName: String
    init(keyCode: Key, mods: NSEventModifierFlags, app: String){
        appName = app
        super.init(keyCode: keyCode, mods: mods)
    }
    @objc override func handler(_ sender: Any){
        print("app open")
        NSWorkspace.shared().launchApplication(appName)
    }
}

enum Key: Int{
    case A                    = 0x00
    case B                    = 0x0B
    case C                    = 0x08
    case D                    = 0x02
    case E                    = 0x0E
    case F                    = 0x03
    case G                    = 0x05
    case H                    = 0x04
    case I                    = 0x22
    case J                    = 0x26
    case K                    = 0x28
    case L                    = 0x25
    case M                    = 0x2E
    case N                    = 0x2D
    case O                    = 0x1F
    case P                    = 0x23
    case Q                    = 0x0C
    case R                    = 0x0F
    case S                    = 0x01
    case T                    = 0x11
    case U                    = 0x20
    case V                    = 0x09
    case W                    = 0x0D
    case X                    = 0x07
    case Y                    = 0x10
    case Z                    = 0x06
    case _0                   = 0x1D
    case _1                   = 0x12
    case _2                   = 0x13
    case _3                   = 0x14
    case _4                   = 0x15
    case _5                   = 0x17
    case _6                   = 0x16
    case _7                   = 0x1A
    case _8                   = 0x1C
    case _9                   = 0x19
    case Equal                = 0x18
    case Minus                = 0x1B
    case RightBracket         = 0x1E
    case LeftBracket          = 0x21
    case Quote                = 0x27
    case Semicolon            = 0x29
    case Backslash            = 0x2A
    case Comma                = 0x2B
    case Slash                = 0x2C
    case Period               = 0x2F
    case Grave                = 0x32
    case KeypadDecimal        = 0x41
    case KeypadMultiply       = 0x43
    case KeypadPlus           = 0x45
    case KeypadClear          = 0x47
    case KeypadDivide         = 0x4B
    case KeypadEnter          = 0x4C
    case KeypadMinus          = 0x4E
    case KeypadEquals         = 0x51
    case Keypad0              = 0x52
    case Keypad1              = 0x53
    case Keypad2              = 0x54
    case Keypad3              = 0x55
    case Keypad4              = 0x56
    case Keypad5              = 0x57
    case Keypad6              = 0x58
    case Keypad7              = 0x59
    case Keypad8              = 0x5B
    case Keypad9              = 0x5C
    case Return               = 0x24
    case Tab                  = 0x30
    case Space                = 0x31
    case Delete               = 0x33
    case Escape               = 0x35
    case Command              = 0x37
    case Shift                = 0x38
    case CapsLock             = 0x39
    case Option               = 0x3A
    case Control              = 0x3B
    case RightShift           = 0x3C
    case RightOption          = 0x3D
    case RightControl         = 0x3E
    case Function             = 0x3F
    case VolumeUp             = 0x48
    case VolumeDown           = 0x49
    case Mute                 = 0x4A
    case F1                   = 0x7A
    case F2                   = 0x78
    case F3                   = 0x63
    case F4                   = 0x76
    case F5                   = 0x60
    case F6                   = 0x61
    case F7                   = 0x62
    case F8                   = 0x64
    case F9                   = 0x65
    case F10                  = 0x6D
    case F11                  = 0x67
    case F12                  = 0x6F
    case F13                  = 0x69
    case F14                  = 0x6B
    case F15                  = 0x71
    case F16                  = 0x6A
    case F17                  = 0x40
    case F18                  = 0x4F
    case F19                  = 0x50
    case F20                  = 0x5A
    case Help                 = 0x72
    case Home                 = 0x73
    case PageUp               = 0x74
    case ForwardDelete        = 0x75
    case End                  = 0x77
    case PageDown             = 0x79
    case LeftArrow            = 0x7B
    case RightArrow           = 0x7C
    case DownArrow            = 0x7D
    case UpArrow              = 0x7E
}
