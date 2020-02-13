//
//  MainViewController.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/10/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
  
  var tableView: UITableView! { get set }
  var toCache: Bool { get }
  
  func setData(data: [DataModel]?)
  func setupButton()
  func setupNavBar(
    with title: String,
    rightTitle: String,
    rightSelector: Selector?,
    leftSelector: Selector?)
  func setupTableView()
  func setToCache(_ toCache: Bool)
  
}

class MainViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var applyButton: UIButton!
  
  var presenter: MainViewPresenterProtocol!
  
  private var cellId = String(describing: SliderTVC.self)
  private(set) var toCache = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    presenter?.setData(toCache: true)
  }
  
  func setToCache(_ toCache: Bool) {
    self.toCache = toCache
  }
  
}

extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    presenter.getNumberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let index = indexPath.section
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SliderTVC,
      let mappedData = presenter.getCellData(
        cell,
        for: index,
        toCache: toCache) as? MappedData {
      
      setupCell(cell, with: mappedData, and: index)
      return cell
    }
    return UITableViewCell()
  }
  
  private func setupCell(_ cell: SliderTVC, with data: MappedData, and index: Int) {
    cell.setCell(with: index, leftButtonX: data.leftButtonCenterX, rightButtonX: data.rightButtonCenterX, leftText: data.leftLabelString, rightText: data.rightLabelString, and: self)
  }
  
}

extension MainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 54
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "\(section + 1)"
  }
  
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}

extension MainViewController: SliderDelegate {
  
  func didChangeButtonValue(gesture: UIPanGestureRecognizer) {
    if let view = gesture.view {
      switch gesture.state {
      case .changed:
        handleSliderInteraction(
          gesture: gesture,
          view: view)
//        view.center.x = gesture.location(in: view.superview).x
      default:
        break
      }
    }
  }
  
  func didTapOnSlider(gesture: UITapGestureRecognizer) {
    if let view = gesture.view {
      switch gesture.state {
      case .began:
        handleSliderInteraction(
          gesture: gesture,
          view: view)
      default:
        break
      }
    }
  }
  
  private func handleSliderInteraction(
    gesture: UIGestureRecognizer,
    view: UIView) {
    
    guard let cell = view.superview?.superview as? SliderTVC,
      let data = presenter?.data else { return }
    let index = cell.tag
    var dataM = data[index]
    if SliderHandler.reactToUserAction(
      view,
      gesture: gesture,
      sliderCell: cell,
      index: index,
      data: &dataM) {
      
      presenter?.setDataModel(dataM, for: index)
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
      target: presenter,
      action: rightSelector)
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(named: "CrossIcon"),
      style: .plain,
      target: presenter,
      action: leftSelector)
  }
  
  func setData(data: [DataModel]?) {
    tableView.reloadData()
  }
  
  func setupTableView() {
    tableView.register(
      UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    tableView.backgroundColor = .systemGroupedBackground
  }
  
}
