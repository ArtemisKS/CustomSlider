//
//  DataModel.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/9/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation

struct DataModel {
  
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
}
