//
//  UIView.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIView {
    
    /// setter and getter for cornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    /// setter and getter for borderWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    @discardableResult
    func layoutSetHeight(_ height: CGFloat,
                         priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: height)
        
        if let priority = priority {
            constraint.priority = priority
        }
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func layoutSetWidth(_ width: CGFloat,
                        priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: width)
        if let priority = priority {
            constraint.priority = priority
        }
        self.addConstraint(constraint)
        return constraint
    }
   
    @discardableResult
    func layoutSetCenterX(to view: UIView, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerX,
                                            multiplier: 1.0,
                                            constant: 0)
        
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func layoutSetCenterY(to view: UIView, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerY,
                                            multiplier: 1.0,
                                            constant: 0)
        
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }
    
}
