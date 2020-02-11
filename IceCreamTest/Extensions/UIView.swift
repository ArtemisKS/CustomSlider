//
//  UIView.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/10/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  func applyBorderRadius(_ radius: CGFloat = 10) {
    
    clipsToBounds = true
    layer.cornerRadius = radius
  }
  
  func applyShadow(
    cornerRadius: CGFloat = 10,
    shadowOpacity: Float = 1,
    shadowRadius: CGFloat = 10,
    shadowOffset: CGSize = .zero) {
    
    let shadowPath = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: cornerRadius)
    let layer = CALayer()
    layer.shadowPath = shadowPath.cgPath
    layer.shadowColor = UIColor(
      red: 0,
      green: 0.643,
      blue: 1,
      alpha: 0.45).cgColor
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.bounds = bounds
    layer.position = center
    self.layer.addSublayer(layer)
  }
}
