//
//  PrefWindowController.swift
//  sa
//
//  Created by Yushi Nakai on 3/16/17.
//  Copyright © 2017 isasaka. All rights reserved.
//

import Foundation
import Cocoa
import Magnet
import KeyHolder

class PrefWindowController: NSViewController{
    @IBOutlet weak var recordView: RecordView!
    override func viewDidLoad() {
        print("vew")
        
        recordView.tintColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
        let keyCombo = KeyCombo(doubledCocoaModifiers: .command)
        recordView.keyCombo = keyCombo
        recordView.delegate = self
    }
    func hotkeyCalled() {
        print("HotKey called!!!!")
    }
}

extension PrefWindowController: RecordViewDelegate {
    func recordViewShouldBeginRecording(_ recordView: RecordView) -> Bool {
        return true
    }
    
    func recordView(_ recordView: RecordView, canRecordKeyCombo keyCombo: KeyCombo) -> Bool {
        // You can customize validation
        return true
    }
    
    func recordViewDidClearShortcut(_ recordView: RecordView) {
        print("clear shortcut")
        HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
    }
    
    func recordViewDidEndRecording(_ recordView: RecordView) {
        print("end recording")
    }
    
    func recordView(_ recordView: RecordView, didChangeKeyCombo keyCombo: KeyCombo) {
        HotKeyCenter.shared.unregisterHotKey(with: "KeyHolderExample")
        let hotKey = HotKey(identifier: "KeyHolderExample", keyCombo: keyCombo, target: self, action: #selector(hotkeyCalled))
        hotKey.register()
    }
}
