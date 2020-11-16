//
//  CGFloatExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2019/12/9.
//  Copyright © 2019 ym. All rights reserved.
//

import CoreGraphics.CGBase
import UIKit.UIGeometry

public extension CGFloat {
    func less(horizontalInsets: UIEdgeInsets) -> CGFloat {
        return self - horizontalInsets.horizontalTotalValue
    }
    func less(verticalInsets: UIEdgeInsets) ->CGFloat {
        return self - verticalInsets.verticalTotalValue
    }
    func add(horizontalInsets: UIEdgeInsets) -> CGFloat {
        return self + horizontalInsets.horizontalTotalValue
    }
    func add(verticalInsets: UIEdgeInsets) ->CGFloat {
        return self + verticalInsets.verticalTotalValue
    }
    func mid(lessValue value: CGFloat = 0) -> CGFloat {
        return (self - value) / 2
    }
}
