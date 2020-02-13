//
//  Assembler.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/9/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation
import UIKit

protocol AssemblerBuilderProtocol {
  func createFirstController(router: RouterProtocol) -> UIViewController
  func createMainController(data: [DataModel]?, router: RouterProtocol) -> UIViewController
}

class AssemblerBuilder: AssemblerBuilderProtocol {
  func createFirstController(router: RouterProtocol) -> UIViewController {
    let view = FirstViewController.loadFromNib()
    let presenter = FirstPresenter(view: view, router: router)
    view.presenter = presenter
    return view
  }
  
  private func getViewControllerFromXIB(of type: UIViewController.Type) -> UIViewController? {
    return UIViewController(nibName: String(describing: type), bundle: nil)
  }
  
  func createMainController(data: [DataModel]?, router: RouterProtocol) -> UIViewController {
    //TODO: - code
    let view = MainViewController.loadFromNib()
    let presenter = MainPresenter(view: view, router: router, data: data)
    view.presenter = presenter
//    let presenter =
    return view
  }
  
  
}
