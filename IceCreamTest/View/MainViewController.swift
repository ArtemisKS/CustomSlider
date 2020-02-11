//
//  MainViewController.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/10/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
  
  func setData(data: [DataModel]?)
  func setupButton()
  func setupNavBar(
    with title: String,
    rightTitle: String,
    rightSelector: Selector?,
    leftSelector: Selector?)
  func setupTableView()
  
}

class MainViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var applyButton: UIButton!
  
  var presenter: MainViewPresenterProtocol!
  
  private var cellId = String(describing: SliderTVC.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
}

extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.getNumberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let index = indexPath.row
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SliderTVC,
      let mappedData = presenter.getCellData(cell, for: index) as? MappedData {
      
      setupCell(cell, with: mappedData, and: index)
      return cell
    }
    return UITableViewCell()
  }
  
  private func setupCell(_ cell: SliderTVC, with data: MappedData, and index: Int) {
    cell.setCell(with: index, leftButtonX: data.leftButtonCenterX, rightButtonX: data.rightButtonCenterX, leftText: data.leftLabelString, rightText: data.rightLabelString, and: self)
  }
  
}

extension MainViewController: SliderDelegate {
  
  func didChangeButtonValue(gesture: UIPanGestureRecognizer) {
    if let view = gesture.view {
      switch gesture.state {
      case .changed:
        view.center.x = gesture.location(in: view.superview).x
      default:
        break
      }
    }
  }
  
  func didTapOnSlider(gesture: UITapGestureRecognizer) {
    if let view = gesture.view {
      switch gesture.state {
      case .changed:
        view.center.x = gesture.location(in: view.superview).x
      default:
        break
      }
    }
  }
  
}

extension MainViewController: MainViewProtocol {
  
  func setupButton() {
    applyButton.applyBorderRadius()
    applyButton.applyShadow()
  }
  
  func setupNavBar(
    with title: String,
    rightTitle: String,
    rightSelector: Selector?,
    leftSelector: Selector?) {
    
    navigationItem.title = title
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: rightTitle,
      style: .plain,
      target: self,
      action: rightSelector)
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(),
      style: .plain,
      target: self,
      action: leftSelector)
  }
  
  func setData(data: [DataModel]?) {
    
  }
  
  func setupTableView() {
    tableView.register(
      UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
  }
  
  
  
}
