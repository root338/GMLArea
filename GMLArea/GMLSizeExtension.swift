//
//  MLSizeExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 ym. All rights reserved.
//

import CoreGraphics.CGGeometry
import UIKit.UIGeometry

//MARK:- 静态初始化方法
public extension CGSize {
    static var maxSize : CGSize {
        return CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
    static func minSize(_ size: CGSize, sizes: CGSize...) -> CGSize {
        let count = sizes.count
        switch count {
        case 1:
            return CGSize(width: min(size.width, sizes[0].width), height: min(size.height, sizes[0].height))
        default:
            var minWidth = size.width
            var minHeight = size.height
            for s in sizes {
                minWidth = min(minWidth, s.width)
                minHeight = min(minHeight, s.height)
            }
            return CGSize(width: minWidth, height: minHeight)
        }
    }
    static func maxSize(_ size: CGSize, sizes: CGSize...) -> CGSize {
        let count = sizes.count
        switch count {
        case 1:
            return CGSize(width: max(size.width, sizes[0].width), height: max(size.height, sizes[0].height))
        default:
            var minWidth = size.width
            var minHeight = size.height
            for s in sizes {
                minWidth = max(minWidth, s.width)
                minHeight = max(minHeight, s.height)
            }
            return CGSize(width: minWidth, height: minHeight)
        }
    }
}

//MARK:- 扩展方法
public extension CGSize {
    
    var areaGreaterZero : Bool {
        return self.width > 0.01 && self.height > 0.01
    }
    func add(value: CGFloat) -> CGSize {
        return CGSize(width: self.width + value, height: self.height + value)
    }
    func add(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        return CGSize(width: self.width + (width ?? 0), height: self.height + (height ?? 0))
    }
    func add(size: CGSize) -> CGSize {
        return CGSize(width: self.width + size.width, height: self.height + size.height)
    }
    /// 加一个UIEdgeInsets
    func add(insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: self.width + insets.horizontalTotalValue, height: self.height + insets.verticalTotalValue)
    }
    /// 减一个UIEdgeInsets
    func less(insets: UIEdgeInsets) -> CGRect {
        return CGRect(x: insets.left,
                      y: insets.top,
                      width: self.width - insets.horizontalTotalValue,
                      height: self.height - insets.verticalTotalValue)
    }
    /// 减 size
    func less(size: CGSize) -> CGSize {
        return CGSize(width: self.width - size.width,
                      height: self.height - size.height)
    }
    func set(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        return CGSize(width: width ?? self.width, height: height ?? self.height)
    }
}
