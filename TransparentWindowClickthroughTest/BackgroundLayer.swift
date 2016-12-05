//
//  BackgroundLayer.swift
//  TransparentWindowClickthroughTest
//
//  Created by Alexander Hofstede on 05/12/2016.
//  Copyright © 2016 Hofstede Software. All rights reserved.
//

import Cocoa

class BackgroundLayer: CALayer {

    var view: NSView?
    var path = CGMutablePath()

    override init() {
        super.init()

        self.needsDisplayOnBoundsChange = true
        self.masksToBounds = false
        self.mask = CAShapeLayer()
        self.backgroundColor = NSColor.alternateSelectedControlColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(view: NSView) {
        self.init()
        self.view = view
        self.view!.wantsLayer = true

        let rect = self.view!.bounds
        let topLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let topRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeft = rect.origin

        // Draw path
        path.move(to: topRight)
        path.addLine(to: NSPoint(x: topRight.x - topRight.x / 3, y: topRight.y))
        path.addLine(to: NSPoint(x: topRight.x - topRight.x / 3, y: topRight.y - 50))
        path.addLine(to: NSPoint(x: topRight.x - (topRight.x / 3 * 2), y: topRight.y - 50))
        path.addLine(to: NSPoint(x: topRight.x - (topRight.x / 3 * 2), y: topRight.y))
        path.addLine(to: NSPoint(x: topLeft.x, y: topLeft.y))
        path.addLine(to: NSPoint(x: topLeft.x, y: topLeft.y - topLeft.y / 3))
        path.addLine(to: NSPoint(x: topLeft.x + 50, y: topLeft.y - topLeft.y / 3))
        path.addLine(to: NSPoint(x: topLeft.x + 50, y: topLeft.y - (topLeft.y / 3 * 2)))
        path.addLine(to: NSPoint(x: topLeft.x, y: topLeft.y - (topLeft.y / 3 * 2)))
        path.addLine(to: NSPoint(x: bottomLeft.x, y: bottomLeft.y))
        path.addLine(to: NSPoint(x: bottomRight.x, y: bottomRight.y))
        path.closeSubpath()

        (self.mask as! CAShapeLayer).path = self.path

        self.setNeedsDisplay()
    }

    override func hitTest(_ p: CGPoint) -> CALayer? {
        if self.path.contains(p) {
            Swift.print("Hit in layer")
            return self
        }
        Swift.print("Hit outside layer")
        return nil
    }
}
