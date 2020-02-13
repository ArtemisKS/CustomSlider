//
//  Presenter.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/9/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation

protocol FirstViewProtocol: class {
  func setupButton(with title: String)
  func setupDataLabel(with title: String)
}

protocol FirstViewPresenterProtocol: class {
  init(view: FirstViewProtocol, router: RouterProtocol)
  var data: [DataModel]? { get set }
  func tapOnData()
  func setupView()
}

class FirstPresenter: FirstViewPresenterProtocol {
  
  weak var view: FirstViewProtocol?
  var router: RouterProtocol?
  var data: [DataModel]?
  
  required init(view: FirstViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  func tapOnData() {
    router?.showDetail(with: data)
  }
  
  func setupView() {
    let labelTitle = confLabelTitle()
    view?.setupButton(with: data != nil
      ? "Изменить фильтры" : "Выбрать фильтры")
    view?.setupDataLabel(with: labelTitle)
  }
  
  private func confLabelTitle() -> String {
    if let data = data, data.count == DataConfig.defData.count {
      return """
      1. \(data[0].lowerRange - data[0].upperRange)
      2. \(data[1].lowerRange - data[1].upperRange)
      3. \(data[2].lowerRange - data[2].upperRange)
      4. \(data[3].lowerRange - data[3].upperRange)
      """
    } else {
      return "Нет выбранных данных"
    }
  }
  
}
