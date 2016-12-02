//
//  MaskedView.swift
//  TransparentWindowClickthroughTest
//
//  Created by Alexander Hofstede on 01/12/2016.
//  Copyright © 2016 Hofstede Software. All rights reserved.
//

import Cocoa

class MaskedView: NSView {

    let path = NSBezierPath()

    override func draw(_ dirtyRect: NSRect) {
        let rect = self.bounds
        let topLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let topRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeft = rect.origin
        // Draw path
        path.move(to: topRight)
        path.line(to: NSPoint(x: topRight.x - topRight.x / 3, y: topRight.y))
        path.line(to: NSPoint(x: topRight.x - topRight.x / 3, y: topRight.y - 50))
        path.line(to: NSPoint(x: topRight.x - (topRight.x / 3 * 2), y: topRight.y - 50))
        path.line(to: NSPoint(x: topRight.x - (topRight.x / 3 * 2), y: topRight.y))
        path.line(to: NSPoint(x: topLeft.x, y: topLeft.y))
        path.line(to: NSPoint(x: topLeft.x, y: topLeft.y - topLeft.y / 3))
        path.line(to: NSPoint(x: topLeft.x + 50, y: topLeft.y - topLeft.y / 3))
        path.line(to: NSPoint(x: topLeft.x + 50, y: topLeft.y - (topLeft.y / 3 * 2)))
        path.line(to: NSPoint(x: topLeft.x, y: topLeft.y - (topLeft.y / 3 * 2)))
        path.line(to: NSPoint(x: bottomLeft.x, y: bottomLeft.y))
        path.line(to: NSPoint(x: bottomRight.x, y: bottomRight.y))
        path.close()
        // Fill
        NSColor(calibratedRed:0, green:0, blue:0, alpha:0.75).set()
        path.fill()
    }

    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        if let window = self.window {
            if self.path.contains(point) {
                // Inside
                Swift.print("Hittest inside \(point) \(window.convertPointFromScreen(NSEvent.mouseLocation())) \(window.mouseLocationOutsideOfEventStream)")
                return super.hitTest(point)
            }
            // FIXME Using window.ignoresMouseEvents hack below sort of works
//            // Outside, FIXME turn off mouse events for the window temporarily so it gets passed on
//            Swift.print("Ignoring mouse events")
//            window.ignoresMouseEvents = true
//            // Turn back on after a bit (mouseUp wasn't a candidate to do this since we need to support two-finger touchpad drag events also)
//            let delayTime = DispatchTime.now() + 2.5 * Double(NSEC_PER_SEC) / Double(NSEC_PER_SEC)
//            DispatchQueue.main.asyncAfter(deadline: delayTime) {
//                Swift.print("Stopped ignoring mouse events")
//                window.ignoresMouseEvents = false
//            }
        }
        Swift.print("Hittest outside")
        return nil
    }
}

extension NSWindow {
    func convertPointFromScreen(_ point: NSPoint)-> NSPoint {
        let rectInScreenCoords = NSRect(x: point.x, y: point.y, width: 1, height: 1)
        let rectInWindowCoords = self.convertFromScreen(rectInScreenCoords)
        return NSPoint(x: rectInWindowCoords.origin.x, y: rectInWindowCoords.origin.y)
    }
}
