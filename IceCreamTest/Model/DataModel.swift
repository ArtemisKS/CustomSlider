//
//  DataModel.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/9/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation

struct DataModel: CustomStringConvertible {
  
  let name = "ночь"
  
  private var lowerRangeVal: Int?
  private var upperRangeVal: Int?
  private var stepVal: Int?
  var lowerRange: Int
  var upperRange: Int
  
  var upperRangeValue: Int {
    get {
      return upperRangeVal ?? 0
    }
    set {
      if upperRangeVal == nil {
        upperRangeVal = newValue
      }
    }
  }
  
  var lowerRangeValue: Int {
    get {
      lowerRangeVal ?? 0
    }
    set {
      if lowerRangeVal == nil {
        lowerRangeVal = newValue
      }
    }
  }
  
  var stepValue: Int {
    get {
      stepVal ?? 0
    }
    set {
      if stepVal == nil {
        stepVal = newValue
      }
    }
  }
  
  init(
    lowerRangeVal: Int,
    upperRangeVal: Int,
    stepVal: Int) {
    
    self.lowerRangeVal = lowerRangeVal
    self.upperRangeVal = upperRangeVal
    self.stepVal = stepVal
    lowerRange = lowerRangeVal
    upperRange = upperRangeVal
  }
  
  init(data: DataModel) {
    self.lowerRangeVal = data.lowerRangeVal
    self.upperRangeVal = data.upperRangeVal
    self.stepVal = data.stepVal
    self.lowerRange = data.lowerRange
    self.upperRange = data.upperRange
  }
  
  var description: String {
    return """
    lowerRangeVal: \(lowerRangeVal!)
    upperRangeVal: \(upperRangeVal!)
    stepVal: \(stepVal!)
    lowerRange: \(lowerRange)
    upperRange: \(upperRange)
    """
  }
}
