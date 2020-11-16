//
//  CGRectExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import UIKit.UIGeometry
import CoreGraphics.CGGeometry

public extension CGRect {
    
    /// {0, 0, width, height}
    var bounds: CGRect {
        return CGRect(origin: .zero, size: self.size)
    }
    /// {x + x, y + y, width, height}
    func offset(x: CGFloat? = nil, y: CGFloat? = nil) -> CGRect {
        var rect = self
        rect.origin = CGPoint.init(x: self.minX + (x ?? 0), y: self.minY + (y ?? 0))
        return rect
    }
    /// 为Rect排除外边距 {x + left, y + top, width - (left + right), height - (top + bottom)}
    func less(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX + insets.left, y: self.minY + insets.top, width: self.width - insets.left - insets.right, height: self.height - insets.top - insets.bottom)
    }
    /// 为Rect增加外边距 {x - left, y - top, width + (left + right), height + (top + bottom)}
    func add(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX - insets.left, y: self.minY - insets.top, width: self.width + insets.left + insets.right, height: self.height + insets.top + insets.bottom)
    }
    
    /// 设置 CGRect 的 y 和 height
    /// - Parameters:
    ///   - verticalAlignment: y 的垂直对齐方式，随着该值的变化，起始 y 值会不同
    func set(height: CGFloat, verticalAlignment: GMLVerticalAlignment = GMLVerticalAlignment.top, offset: CGFloat = 0) -> CGRect {
        var frame = self
        frame.size.height = height
        let originY : CGFloat
        switch verticalAlignment {
        case .top:
            originY = self.minY
        case .center:
            originY = self.midY - height / 2
        case .bottom:
            originY = self.maxY - height
        case .fill:
            originY = self.minY
        }
        frame.origin.y = originY + offset
        return frame
    }
    
    /// 设置 CGRect 的 x 和 width
    /// - Parameters:
    ///   - horizontalAlignment: x 的水平对齐方式，随着该值的变化，起始 x 值会不同
    func set(width: CGFloat, horizontalAlignment: GMLHorizontalAlignment = GMLHorizontalAlignment.left, offset: CGFloat = 0) -> CGRect {
        var frame = self
        frame.size.width = height
        let originX : CGFloat
        switch horizontalAlignment {
        case .left:
            originX = self.minX
        case .center:
            originX = self.midX - width / 2
        case .right:
            originX = self.maxX - width
        case .fill:
            originX = self.minX
        }
        frame.origin.x = originX + offset
        return frame
    }
}

//MARK:- 对齐计算
public extension CGRect {
    /// size 在 CGRect 中的居中区域
    /// - Parameters:
    ///   - size: 指定大小
    ///   - offset: 居中偏移
    ///   - x: 设置 x
    ///   - y: 设置 y
    func center(size: CGSize, offset: CGPoint = CGPoint.zero, setX x: CGFloat? = nil, setY y: CGFloat? = nil) -> CGRect {
        return CGRect(
            x: (x ?? (self.minX + (self.size.width - size.width) / 2)) + offset.x,
            y: (y ?? (self.minY + (self.size.height - size.height) / 2)) + offset.y,
            width: size.width,
            height: size.height
        )
    }
    func center(width: CGFloat? = nil, height: CGFloat? = nil, offset: CGPoint = CGPoint.zero, setX x: CGFloat? = nil, setY y: CGFloat? = nil) -> CGRect {
        return CGRect(
            x: (x ?? (self.minX + (self.size.width - size.width) / 2)) + offset.x,
            y: (y ?? (self.minY + (self.size.height - size.height) / 2)) + offset.y,
            width: width ?? self.width,
            height: height ?? self.height
        )
    }
    
    /// rect 内指定 size 在不同填充下的 rect 值
    func size(_ size: CGSize, contentMode: UIView.ContentMode, offset: CGPoint = CGPoint.zero) -> CGRect {
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var width = size.width
        var height = size.height
        
        switch contentMode {
        case .scaleToFill:
            width = self.width
            height = self.height
        case .scaleAspectFit: fallthrough
        case .scaleAspectFill:
            let s1 = size.width / self.width
            let s2 = size.height / self.height
            if (s1 < s2) {
                if (contentMode == .scaleAspectFit) {
                    width   = size.width / s2;
                    height  = size.height;
                }else {
                    width   = size.width;
                    height  = size.height / s1;
                }
            }else {
                if (contentMode == .scaleAspectFit) {
                    width   = size.width;
                    height  = size.height / s1;
                }else {
                    width   = size.width / s2;
                    height  = size.height;
                }
            }
            x = self.width.mid(lessValue: width)
            y = self.height.mid(lessValue: height)
        case .redraw: break
        case .center: return center(size: size)
        case .top:
            x = self.width.mid(lessValue: width)
        case .bottom:
            x = self.width.mid(lessValue: width)
            y = self.height - height
        case .left:
            y = self.height.mid(lessValue: height)
        case .right:
            x = self.width - width
            y = self.height.mid(lessValue: height)
        case .topLeft: break
        case .topRight:
            x = self.width - width
        case .bottomLeft:
            y = self.height - height
        case .bottomRight:
            x = self.width - width
            y = self.height - height
        @unknown default: break
        }
        return CGRect(x: x + self.minX + offset.x, y: y + self.minY + offset.y, width: width, height: height)
    }
}

public extension CGRect {
    /// 以 maxY 值为轴，转换的镜像（向下翻转）
    var mirrorMaxY : CGRect {
        return mirror(y: self.maxY)
    }
    /// 以 minY 值为轴，转换的镜像（向上翻转）
    var mirrorMinY : CGRect {
        return mirror(y: self.minY)
    }
    /// 以 maxX 值为轴，转换的镜像（向右翻转）
    var mirrorMaxX : CGRect {
        return mirror(x: self.maxX)
    }
    /// 以 minX 值为轴，转换的镜像（向左翻转）
    var mirrorMinX : CGRect {
        return mirror(x: self.minX)
    }
    /// 已给定 x, y 轴值转换的镜像
    func mirror(x: CGFloat? = nil, y: CGFloat? = nil) -> CGRect {
        var rect = self
        if let mirrorX = x {
            let originX : CGFloat
            if mirrorX <= self.minX {
                originX = mirrorX - self.width - (self.minX - mirrorX)
            }else if mirrorX >= self.maxX {
                originX = mirrorX + (mirrorX - self.maxX)
            }else if mirrorX < self.midX {
                originX = mirrorX - (mirrorX - self.minX)
            }else {
                originX = mirrorX - (self.maxX - mirrorX)
            }
            rect.origin.x = originX
        }
        if let mirrorY = y {
            let originY : CGFloat
            if mirrorY <= self.minY {
                originY = mirrorY - self.height - (self.minY - mirrorY)
            }else if mirrorY >= self.maxY {
                originY = mirrorY + (mirrorY - self.maxY)
            }else if mirrorY < self.midY {
                originY = mirrorY - (mirrorY - self.minY)
            }else {
                originY = mirrorY - (self.maxY - mirrorY)
            }
            rect.origin.y = originY
        }
        return rect
    }
}
