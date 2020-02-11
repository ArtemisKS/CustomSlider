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

class SliderTVC: UITableViewCell {
  
  @IBOutlet weak var sliderView: UIView!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var leftLabel: UILabel!
  @IBOutlet weak var rightLabel: UILabel!
  
  private var delegate: SliderDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setCell(
    with index: Int,
    leftButtonX: CGFloat,
    rightButtonX: CGFloat,
    leftText: String,
    rightText: String,
    and sliderDelegate: SliderDelegate) {
    
    self.tag = index
    self.delegate = sliderDelegate
    leftButton.frame.origin = CGPoint(
      x: leftButtonX,
      y: leftButton.frame.origin.y)
    rightButton.frame.origin = CGPoint(
      x: rightButtonX,
      y: rightButton.frame.origin.y)
    setLabels(leftText: leftText, rightText: rightText)
  }
  
  private func setButtonsActions() {
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(delegate?.didChangeButtonValue(gesture:)))
    for case let view? in [leftButton, rightButton] {
      view.addGestureRecognizer(gesture)
    }
  }
  
  func setSliderAction() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(delegate?.didTapOnSlider(gesture:)))
    sliderView.addGestureRecognizer(gesture)
  }
  
  func setLabels(
    leftText: String,
    rightText: String) {
    
    leftLabel.text = leftText
    rightLabel.text = rightText
  }
  
}
