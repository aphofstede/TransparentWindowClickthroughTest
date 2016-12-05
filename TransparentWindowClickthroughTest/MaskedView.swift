//
//  MaskedView.swift
//  TransparentWindowClickthroughTest
//
//  Created by Alexander Hofstede on 01/12/2016.
//  This is free and unencumbered software released into the public domain.
//

import Cocoa

class MaskedView: NSView {

    let path = NSBezierPath()

    override func viewDidMoveToSuperview() {
        self.layer = BackgroundLayer(view: self)
    }

    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        return self.layer?.hitTest(point) == nil ? nil : super.hitTest(point)
    }

}

extension NSWindow {
    func convertPointFromScreen(_ point: NSPoint)-> NSPoint {
        let rectInScreenCoords = NSRect(x: point.x, y: point.y, width: 1, height: 1)
        let rectInWindowCoords = self.convertFromScreen(rectInScreenCoords)
        return NSPoint(x: rectInWindowCoords.origin.x, y: rectInWindowCoords.origin.y)
    }
}
