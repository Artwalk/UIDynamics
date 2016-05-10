//
//  Extension.swift
//  UIDynamics
//
//  Created by Art on 5/9/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

@IBDesignable
class CRView: UIView {
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
}