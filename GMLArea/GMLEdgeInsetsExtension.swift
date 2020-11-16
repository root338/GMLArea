//
//  CGUIEdgeInsetsExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 ym. All rights reserved.
//

import UIKit.UIGeometry

//MARK:- 初始化方法
public extension UIEdgeInsets {
    
    init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.init(top: top ?? 0,
                  left: left ?? 0,
                  bottom: bottom ?? 0,
                  right: right ?? 0)
    }
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, other: CGFloat) {
        self.init(top: top ?? other,
                  left: left ?? other,
                  bottom: bottom ?? other,
                  right: right ?? other)
    }
    init(horizontalValue hValue: CGFloat? = nil, verticalValue vValue: CGFloat? = nil) {
        self.init(top: vValue ?? 0,
                  left: hValue ?? 0,
                  bottom: vValue ?? 0,
                  right: hValue ?? 0)
    }
}
//MARK:- 扩展方法
public extension UIEdgeInsets {
    var horizontalTotalValue: CGFloat {
        return self.left + self.right
    }
    var verticalTotalValue: CGFloat {
        return self.top + self.bottom
    }
    var point : CGPoint {
        return CGPoint.init(x: self.left, y: self.top)
    }
}
