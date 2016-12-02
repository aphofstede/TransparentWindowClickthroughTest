//
//  CustomWindow.swift
//  TransparentWindowClickthroughTest
//
//  Created by Alexander Hofstede on 01/12/2016.
//  Copyright © 2016 Hofstede Software. All rights reserved.
//

import Cocoa

class CustomWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: .borderless, backing: bufferingType, defer: false)

        self.backgroundColor = NSColor.clear
        self.isMovableByWindowBackground = true
    }
    
}
