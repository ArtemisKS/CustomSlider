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
  private static var namesDict = [Int : String]()
  
  private static var currentButtonX: CGFloat = 0
  
  static func reactToUserAction(
    _ view: UIView,
    gesture: UIGestureRecognizer,
    sliderCell: SliderTVC,
    index: Int,
    data: inout DataModel) -> Bool {
    
    let bObj = getBasicData(sliderCell, index: index, data: data)
    let (leftButtonX, rightButtonX) = (
      sliderCell.leftButton.center.x,
      sliderCell.rightButton.center.x)
    
    let gestLocation = gesture.location(in: view.superview).x
//    if currentButtonX == 0 { currentButtonX = view.center.x }
    if let button = view as? UIButton {
      
      let diffLoc = gestLocation - view.center.x
      
      if bObj.xStep > abs(diffLoc)
        || view.center.x + diffLoc < bObj.leftSliderX - 1
      || view.center.x + diffLoc > bObj.rightSliderX + 1 { return false }
      
      var diff = diffLoc > 0 ? bObj.xStep : -bObj.xStep
      let newViewX = view.center.x + diff
      if newViewX == leftButtonX || newViewX == rightButtonX { diff *= 2 }
      let dataDiff = diff > 0 ? data.stepValue : -data.stepValue
      let isLeftButton = button == sliderCell.leftButton
      
      updateDataVal(
        &data,
        dataDiff: dataDiff,
        isLeftButton: isLeftButton)
      
      if view.center.x == newViewX { return false }
      
      let oldX = view.center.x
      
//      let imData = data
//      doAnim {
        view.center.x = newViewX// - view.center.x
        confLabel(
          sliderCell,
          button: button,
          data: data,
          oldButtonX: oldX)
        
        updateSliderColor(
          sliderCell,
          isLeftButton: isLeftButton,
          newX: newViewX - oldX)
//      }
      
      
//      DispatchQueue.global(qos: .userInteractive).sync {
//        CATransaction.flush()
//      }
//
//      view.center.x = newViewX// - view.center.x
//      confLabel(
//        sliderCell,
//        button: button,
//        data: data,
//        oldButtonX: oldX)
//
////      updateSliderColor(
////        sliderCell,
////        newX: newViewX)
//
//      sliderCell.sliderView.center.x += diff
//
//      DispatchQueue.global(qos: .userInteractive).sync {
//        CATransaction.flush()
//      }
//
//      sliderCell.sliderView.center.x += newViewX - oldX
      
      //      currentButtonX = newViewX
    } else {
      
      if gestLocation == leftButtonX
        || gestLocation == rightButtonX { return false }
      
      let (leftButtonDiff, rightButtonDiff) = (
        leftButtonX - gestLocation,
        rightButtonX - gestLocation)
      
      guard let button = abs(leftButtonDiff) < abs(rightButtonDiff)
        ? sliderCell.leftButton : sliderCell.rightButton else { return false }
      let oldButtonX = button.center.x
      let isLeftButton = button == sliderCell.leftButton
      confButtonPosition(
        button,
        tapLocation: gestLocation,
        basicObj: bObj,
        data: &data,
        isLeftButton: isLeftButton)
      updateSliderColor(
        sliderCell,
        isLeftButton: isLeftButton,
        newX: button.center.x)
      confLabel(
        sliderCell,
        button: button,
        data: data,
        oldButtonX: oldButtonX)
    }
    return true
  }
  
  private static func doAnim(with completion: @escaping () -> Void) {
    
    CATransaction.begin()
    CATransaction.setCompletionBlock {
      completion()
    }
    CATransaction.commit()
  }
  
  private static func updateDataVal(
    _ data: inout DataModel,
    dataDiff: Int,
    isLeftButton: Bool) {
    
    if isLeftButton {
      data.lowerRange += dataDiff
    } else {
      data.upperRange += dataDiff
    }
  }
  
  private static func confButtonPosition(
    _ button: UIButton,
    tapLocation: CGFloat,
    basicObj: BasicData,
    data: inout DataModel,
    isLeftButton: Bool) {
    
    var newX: CGFloat = CGFloat.greatestFiniteMagnitude
    var xDiff: CGFloat = CGFloat.greatestFiniteMagnitude
    
    for xVal in basicObj.xValues {
      xDiff = abs(xVal - tapLocation)
      if xDiff < newX { newX = xDiff }
      else {
        let diff = Int((newX - button.center.x) / basicObj.stepVal)
        updateDataVal(
          &data,
          dataDiff: diff,
          isLeftButton: isLeftButton)
        break
      }
    }
    button.center.x = newX
  }
  
  private static func updateSliderColor(
    _ sliderCell: SliderTVC,
    isLeftButton: Bool,
    newX: CGFloat) {
    
//    if isLeftButton {
//      guard let sv = sliderCell.sliderView else { return }
//
////      let toRight = newX > oldX
////      sv.setGray(toRight)
////      var newX: CGFloat
//
//      sv.setX(newX - oldX)
//    }
//      sliderCell.sliderView.center.x += diff
    sliderCell.sliderView.setX(newX, isLeftButton: isLeftButton)
//    }
  }
  
  private static func confLabel(
    _ sliderCell: SliderTVC,
    button: UIButton,
    data: DataModel,
    oldButtonX: CGFloat) {
    
    guard let leftLabel = sliderCell.leftLabel,
      let rightLabel = sliderCell.rightLabel else { return }

    let leftIsNearest = abs(leftLabel.center.x - oldButtonX) < abs(rightLabel.center.x - oldButtonX)
    let label = leftIsNearest ? leftLabel : rightLabel
    
    label.center.x = button.center.x
//    DispatchQueue.main.async {
      if leftLabel.frame.intersects(rightLabel.frame) {
//        leftLabel.text = "2"
        confLabelText(
          for: rightLabel,
          from: data,
          config: .intersected)
      } else {
//        leftLabel.text = "1"
        confLabelText(
          for: label,
          from: data,
          config: .usual(leftLabel: leftIsNearest))
//      }
    }
  }
  
  private enum LabelCase {
    case usual(leftLabel: Bool)
    case intersected
  }
  
  static private func confLabelText(
    for label: UILabel,
    from data: DataModel,
    config: LabelCase) {
    
    switch config {
    case .usual(leftLabel: let isLeftLabel):
      let val = isLeftLabel ? data.lowerRange : data.upperRange
      let str = "\(val) \(namesDict[val] ?? "")"
//      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
        label.text = str//"21"//
//      }
      print("val: \(val)")
    default:
      label.text = "2" /*"\(data.lowerRange)-\(data.upperRange) \(data.name.getNounOfNumber(data.upperRange, andGender: .feminine))"*/
    }
  }
  
  static func mapToSliderData(
    _ sliderCell: SliderTVC,
    index: Int,
    data: DataModel,
    toCache: Bool) -> MappedData {
    
    let bObj = getBasicData(
      sliderCell,
      index: index,
      data: data,
      toCache: false)
    
    let lowRange = data.lowerRange
    let upRange = data.upperRange
    let leftButtonX = bObj.leftSliderX + bObj.xStep * CGFloat(lowRange - data.lowerRangeValue)
    let rightButtonX = bObj.rightSliderX - bObj.xStep * CGFloat(data.upperRangeValue - upRange)
    let leftLabelX = leftButtonX
    let rightLabelX = rightButtonX
    let leftLabelString = "\(lowRange) \(data.name .getNounOfNumber(lowRange, andGender: .feminine))"
    let rightLabelString = "\(upRange) \(data.name.getNounOfNumber(upRange, andGender: .feminine))"
    
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
    data: DataModel,
    toCache: Bool = true) -> BasicData {
    
    var sliderWidth, stepVal, sliderMinX, sliderMaxX, xStep: CGFloat
    var valDiff: Int
    let width: CGFloat = sliderCell.leftButton.frame.width
    
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
      stepVal = CGFloat(data.stepValue)
      valDiff = (data.upperRangeValue - data.lowerRangeValue + 1) / data.stepValue
      sliderMinX = sliderCell.sliderView.frame.minX + width / 4
      sliderMaxX = sliderCell.sliderView.frame.maxX - width / 4
      xStep = (sliderWidth / CGFloat(valDiff))
    }
    
    var xValues = [CGFloat]()
    
    for i in 1...valDiff {
      xValues.append(xStep * CGFloat(i))
    }
    
    if namesDict.isEmpty {
      for i in data.lowerRangeValue...data.upperRangeValue {
        namesDict[i] = "\(data.name.getNounOfNumber(i, andGender: .feminine))"
      }
    }
    
    let basicObj = BasicData(
      sliderWidth: sliderWidth,
      leftSliderX: sliderMinX,
      rightSliderX: sliderMaxX,
      xStep: xStep,
      xValues: xValues,
      valDiff: valDiff,
      stepVal: stepVal)
    
    if toCache && mappedData[index] == nil { mappedData[index] = basicObj }
    
    return basicObj
  }
}
