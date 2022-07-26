//
//  CustomWindow.swift
//  TransparentWindowClickthroughTest
//
//  Created by Alexander Hofstede on 01/12/2016.
//  This is free and unencumbered software released into the public domain.
//

import Cocoa

class CustomWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: .borderless, backing: bufferingType, defer: false)

        self.backgroundColor = NSColor.clear
        self.isMovableByWindowBackground = true
    }
    
}
