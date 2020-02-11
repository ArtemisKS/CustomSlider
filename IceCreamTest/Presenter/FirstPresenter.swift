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
    setupView()
  }
  
  func tapOnData() {
    router?.showDetail(with: data)
  }
  
  func setupView() {
    view?.setupButton(with: data != nil
      ? "Изменить фильтры" : "Выбрать фильтры")
  }
  
}
