//
//  MappedData.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/11/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation
import UIKit

protocol SliderData {
  var sliderViewWidth: CGFloat { get }
  var leftButtonCenterX: CGFloat { get }
  var rightButtonCenterX: CGFloat { get }
  var leftLabelString: String { get }
  var rightLabelString: String { get }
}

struct MappedData: SliderData {
  
  private(set) var sliderViewWidth: CGFloat
  private(set) var leftButtonCenterX: CGFloat
  private(set) var rightButtonCenterX: CGFloat
  private(set) var leftLabelCenterX: CGFloat
  private(set) var rightLabelCenterX: CGFloat
  private(set) var leftLabelString: String
  private(set) var rightLabelString: String
  
}
