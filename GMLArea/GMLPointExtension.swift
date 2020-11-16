//
//  CGPointExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import CoreGraphics.CGGeometry

public extension CGPoint {
    /// {self.x + x, self.y + y}
    func offset(x: CGFloat? = nil, y: CGFloat? = nil) -> CGPoint {
        return CGPoint.init(x: self.x + (x ?? 0), y: self.y + (y ?? 0))
    }
    func offset(point: CGPoint) -> CGPoint {
        return CGPoint.init(x: self.x + point.x, y: self.y + point.y)
    }
    /// {self.x - x, self.y - y}
    func less(x: CGFloat? = nil, y: CGFloat? = nil) -> CGPoint {
        return CGPoint.init(x: self.x - (x ?? 0), y: self.y - (y ?? 0))
    }
    func less(point: CGPoint) -> CGPoint {
        return CGPoint.init(x: self.x - point.x, y: self.y - point.y)
    }
}
