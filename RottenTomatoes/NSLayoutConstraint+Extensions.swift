//
//  NSLayoutConstraint+Extensions.swift
//  RottenTomatoes
//
//  Created by Josh Lehman on 2/5/15.
//  Copyright (c) 2015 Josh Lehman. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    class func addMultipleConstraints(views: [String: UIView], view: UIView, vflConstraints: [String], options: NSLayoutFormatOptions = nil, metrics: [NSObject:AnyObject]? = nil) {
        for vfl in vflConstraints {
            let constraint = NSLayoutConstraint.constraintsWithVisualFormat(vfl, options: options, metrics: metrics, views: views)
            view.addConstraints(constraint)
        }
    }
}
