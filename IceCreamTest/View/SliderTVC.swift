//
//  SliderTVC.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/11/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import UIKit

@objc protocol SliderDelegate {
  func didChangeButtonValue(gesture: UIPanGestureRecognizer)
  func didTapOnSlider(gesture: UITapGestureRecognizer)
}

@IBDesignable
class SliderView: UIView {
  
//  private(set) var isGray: Bool!
//
//  override func awakeFromNib() {
//    super.awakeFromNib()
//
//    isGray = false
//  }
//
//  func setGray(_ gray: Bool) {
//    isGray = gray
//  }
  
  func setX(
    _ x: CGFloat,
    isLeftButton: Bool) {
//    if isLeftButton {
      center.x += x
//    } else {
//      frame.size = CGSize(
//        width: frame.width + x,
//        height: frame.height)
//    }
//    frame.size = CGSize(width: frame.width - x, height: frame.height)
//    center.x + x
//    frame.size = CGSize(width: frame.width - x, height: frame.height)
//    frame = CGRect(
//    origin: CGPoint(x: frame.origin.x + x, y: frame.origin.y),
//    size: CGSize(width: frame.width - x, height: frame.height))
  }
  
//  override func draw(_ rect: CGRect) {
//    super.draw(rect)
//
//    let color: UIColor = isGray ?
//      .lightGray : .mainBlue
//    color.set()
//    UIRectFill(rect)
//  }
}

class SliderTVC: UITableViewCell {
  
  @IBOutlet weak var backSliderView: SliderView!
  @IBOutlet weak var sliderView: SliderView!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var leftLabel: UILabel!
  @IBOutlet weak var rightLabel: UILabel!
  
  private var delegate: SliderDelegate?
  
  func setCell(
    with index: Int,
    leftButtonX: CGFloat,
    rightButtonX: CGFloat,
    leftText: String,
    rightText: String,
    and sliderDelegate: SliderDelegate) {
    
    self.tag = index
    self.delegate = sliderDelegate
    leftButton.center.x =  leftButtonX
    rightButton.center.x = rightButtonX
    let size = leftButton.frame.width / 2
    let butX = leftButtonX + size
    leftButton.frame = CGRect(
      origin: CGPoint(x: butX, y: leftButton.frame.origin.y),
      size: CGSize(width: rightButtonX - butX, height: leftButton.frame.height))
    setLabels(leftText: leftText, rightText: rightText)
    setSliderAction()
    setButtonsActions()
  }
  
  private func setButtonsActions() {
    let gesture1 = UIPanGestureRecognizer(target: delegate, action: #selector(delegate?.didChangeButtonValue(gesture:)))
    let gesture2 = UIPanGestureRecognizer(target: delegate, action: #selector(delegate?.didChangeButtonValue(gesture:)))
    leftButton.addGestureRecognizer(gesture1)
    rightButton.addGestureRecognizer(gesture2)
  }
  
  func setSliderAction() {
    let gesture = UITapGestureRecognizer(target: delegate, action: #selector(delegate?.didTapOnSlider(gesture:)))
    sliderView.addGestureRecognizer(gesture)
  }
  
  func setLabels(
    leftText: String,
    rightText: String) {
    
    leftLabel.text = leftText
    rightLabel.text = rightText
  }
  
}
