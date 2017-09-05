//
//  RoundedCornersView.swift
//  Pinterest
//
//  Created by neal on 2017/9/5.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {

    @IBInspectable var cornerRadius: CGFloat  = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
