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
  
  var data: [DataModel]? { get }
  
  init(
    view: MainViewProtocol,
    router: RouterProtocol,
    data: [DataModel]?)
  
  func getNumberOfRows() -> Int
  func setData(toCache: Bool)
  func setupView()
  func save()
  func getCellData(_ cell: UITableViewCell, for index: Int, toCache: Bool) -> SliderData?
  func getCell(for index: Int) -> UITableViewCell?
  func setDataModel(
    _ data: DataModel,
    for ind: Int)
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
  }
  
  func setDataModel(
    _ data: DataModel,
    for ind: Int) {
    self.data?[ind] = data
  }
  
  func getCell(for index: Int) -> UITableViewCell? {
    return view?.tableView.cellForRow(at: IndexPath(row: index, section: 0))
  }
  
  func getNumberOfRows() -> Int {
    return data != nil ? data!.count : 0
  }
  
  func save() {
    //TODO: implement save
    popToRoot()
  }
  
  func getCellData(
    _ cell: UITableViewCell,
    for index: Int,
    toCache: Bool) -> SliderData? {
    
    guard let cell = cell as? SliderTVC,
      let data = data else { return nil }
    return SliderHandler.mapToSliderData(
      cell,
      index: index,
      data: data[index],
      toCache: toCache)
  }
  
  func setupView() {
    view?.setupButton()
    view?.setupNavBar(
      with: "Фильтры",
      rightTitle: "Сбросить",
      rightSelector: #selector(discardChanges),
      leftSelector: #selector(popToRoot))
    view?.setupTableView()
    setData(toCache: false)
  }
  
  func setData(toCache: Bool) {
    populateData()
    view?.setToCache(toCache)
    view?.setData(data: data)
  }
  
  @objc private func popToRoot() {
    router?.popToRoot()
  }
  
  @objc private func discardChanges() {
    data = DataConfig.defData
    setData(toCache: true)
  }
  
  private func populateData() {
    if data == nil {
      data = DataConfig.defData
    }
  }
  
}
