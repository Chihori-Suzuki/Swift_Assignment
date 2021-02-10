//
//  UIView+Anchor.swift
//  Assignment1Starter
//
//  Created by Derrick Park on 2019-04-18.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UIView {
  
  func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
    }
    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
    }
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
    }
  }
  
  func anchorEquallyPadding(to view: UIView, paddingSize: CGFloat) {
    topAnchor.constraint(equalTo: view.topAnchor, constant: paddingSize).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: paddingSize).isActive = true
    leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingSize).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: paddingSize).isActive = true
  }
  
  func anchorSize(to view: UIView, widthMuliplier: CGFloat = 1.0, heightMuliplier: CGFloat = 1.0) {
    widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMuliplier).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightMuliplier).isActive = true
  }
  
  /**
   Set width and height constraints with constant values.
   
   Calling this method sets the width and height constraints of the view
   by the value of `width` and `height`.
   
   - Parameter width: The constant width value.
   - Parameter height: The constant height value.
   */
  func anchorSize(width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func alignCenter(to view: UIView) {
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
