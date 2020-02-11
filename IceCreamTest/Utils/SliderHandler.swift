//
//  DataMapper.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/11/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation
import UIKit

struct SliderHandler {
  
  private struct BasicData {
    var sliderWidth: CGFloat
    var leftSliderX: CGFloat
    var rightSliderX: CGFloat
    var xStep: CGFloat
    var xValues: [CGFloat]
    let valDiff: Int
    var stepVal: CGFloat
  }
  
  private static var mappedData = [Int : BasicData]()
  
  static func reactToUserAction(
    view: UIView,
    gesture: UIGestureRecognizer,
    _ sliderCell: SliderTVC,
    index: Int,
    data: DataModel) {
    
    let bObj = getBasicData(sliderCell, index: index, data: data)
    let (leftButtonX, rightButtonX) = (
      sliderCell.leftButton.center.x,
      sliderCell.rightButton.center.x)
    
    let gestLocation = gesture.location(in: view.superview).x
    if let button = view as? UIButton {
      
      let buttonLocation = button.center.x
      
      let diffLoc = gestLocation - buttonLocation
      
      if bObj.stepVal > abs(diffLoc)
        || view.center.x + diffLoc < bObj.leftSliderX
      || view.center.x + diffLoc > bObj.rightSliderX { return }
      let newViewX = diffLoc > 0
        ? view.center.x + bObj.stepVal : view.center.x - bObj.stepVal
      if newViewX == leftButtonX || newViewX == rightButtonX { return }
      view.center.x = newViewX
    } else {
      
      if gestLocation == leftButtonX
        || gestLocation == rightButtonX { return }
      
      let (leftButtonDiff, rightButtonDiff) = (
        leftButtonX - gestLocation,
        rightButtonX - gestLocation)
      
      confButtonPosition(
        abs(leftButtonDiff) < abs(rightButtonDiff)
        ? sliderCell.leftButton : sliderCell.rightButton,
        tapLocation: gestLocation,
        basicObj: bObj)
    }
    
  }
  
  private static func confButtonPosition(
    _ button: UIButton,
    tapLocation: CGFloat,
    basicObj: BasicData) {
    
    var newX: CGFloat = CGFloat.greatestFiniteMagnitude
    var xDiff: CGFloat = CGFloat.greatestFiniteMagnitude
    
    for xVal in basicObj.xValues {
      xDiff = abs(xVal - tapLocation)
      if xDiff < newX { newX = xDiff }
      else { break }
    }
    button.center.x = newX
  }
  
  static func mapToSliderData(
    _ sliderCell: SliderTVC,
    index: Int,
    data: DataModel) -> MappedData {
    
    let bObj = getBasicData(sliderCell, index: index, data: data)
    
    let lowRange = CGFloat(data.lowerRange)
    let upRange = CGFloat(data.upperRange)
    let leftButtonX = bObj.leftSliderX + bObj.xStep * lowRange
    let rightButtonX = bObj.rightSliderX + bObj.xStep * upRange
    let leftLabelX = leftButtonX
    let rightLabelX = rightButtonX
    let leftLabelString = "\(lowRange)".getNounOfNumber("\(lowRange)", andGender: .feminine)
    let rightLabelString = "\(upRange)".getNounOfNumber("\(upRange)", andGender: .feminine)
    
    let mappedObj = MappedData(
      sliderViewWidth: bObj.sliderWidth,
      leftButtonCenterX: leftButtonX,
      rightButtonCenterX: rightButtonX,
      leftLabelCenterX: leftLabelX,
      rightLabelCenterX: rightLabelX,
      leftLabelString: leftLabelString,
      rightLabelString: rightLabelString)
    
    return mappedObj
  }
  
  private static func getBasicData(
    _ sliderCell: SliderTVC,
    index: Int,
    data: DataModel) -> BasicData {
    
    var sliderWidth, stepVal, sliderMinX, sliderMaxX, xStep: CGFloat
    var valDiff: Int
    
    if let obj = mappedData[index] {
      
      (sliderWidth, stepVal, sliderMinX, sliderMaxX, valDiff, xStep) =
        (obj.sliderWidth,
         obj.stepVal,
         obj.leftSliderX,
         obj.rightSliderX,
         obj.valDiff,
         obj.xStep)
    } else {
      
      sliderWidth = sliderCell.sliderView.frame.width
      valDiff = data.upperRangeValue - data.lowerRangeValue
      stepVal = CGFloat(data.stepValue)
      sliderMinX = sliderCell.sliderView.frame.minX
      sliderMaxX = sliderCell.sliderView.frame.maxX
      xStep = stepVal * (sliderWidth / CGFloat(valDiff))
    }
    
    var xValues = [CGFloat]()
    
    for i in 1...valDiff {
      xValues.append(xStep * CGFloat(i))
    }
    
    let basicObj = BasicData(
      sliderWidth: sliderWidth,
      leftSliderX: sliderMinX,
      rightSliderX: sliderMaxX,
      xStep: xStep,
      xValues: xValues,
      valDiff: valDiff,
      stepVal: stepVal)
    
    mappedData[index] = basicObj
    
    return basicObj
  }
}
