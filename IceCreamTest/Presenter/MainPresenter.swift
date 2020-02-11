//
//  MainPresenter.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/10/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewPresenterProtocol: class {
  
  init(
    view: MainViewProtocol,
    router: RouterProtocol,
    data: [DataModel]?)
  
  func getNumberOfRows() -> Int
  func setData()
  func setupView()
  func save()
  func getCellData(_ cell: UITableViewCell, for index: Int) -> SliderData?
}

class MainPresenter: MainViewPresenterProtocol {
  
  weak var view: MainViewProtocol?
  var router: RouterProtocol?
  var data: [DataModel]?
  
  required init(
    view: MainViewProtocol,
    router: RouterProtocol,
    data: [DataModel]?) {
    
    self.view = view
    self.router = router
    self.data = data
    setupView()
  }
  
  func getNumberOfRows() -> Int {
    return data != nil ? data!.count : 0
  }
  
  func save() {
    //TODO: implement save
    popToRoot()
  }
  
  func getCellData(_ cell: UITableViewCell, for index: Int) -> SliderData? {
    guard let cell = cell as? SliderTVC,
      let data = data else { return nil }
    return SliderHandler.mapToSliderData(cell, index: index, data: data[index])
  }
  
  
  
  func setupView() {
    view?.setupButton()
    view?.setupNavBar(
      with: "Фильтры",
      rightTitle: "Сбросить",
      rightSelector: #selector(discardChanges),
      leftSelector: #selector(popToRoot))
    view?.setupTableView()
  }
  
  func setData() {
    view?.setData(data: data)
  }
  
  @objc private func popToRoot() {
    router?.popToRoot()
  }
  
  @objc private func discardChanges() {}
  
}
