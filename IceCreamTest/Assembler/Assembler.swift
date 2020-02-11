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
    let view = FirstViewController()
    let presenter = FirstPresenter(view: view, router: router)
    view.presenter = presenter
    return UIViewController()
  }
  
  func createMainController(data: [DataModel]?, router: RouterProtocol) -> UIViewController {
    //TODO: - code
    let view = MainViewController()
    let presenter = MainPresenter(view: view, router: router, data: data)
    view.presenter = presenter
//    let presenter =
    return view
  }
  
  
}
