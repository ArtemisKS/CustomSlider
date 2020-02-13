//
//  FirstViewController.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/10/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  @IBOutlet weak var chooseButton: UIButton!
  @IBOutlet weak var dataLabel: UILabel!
  
  var presenter: FirstViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.setupView()
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    presenter.tapOnData()
  }
  
}

extension FirstViewController: FirstViewProtocol {
  
  func setupButton(with title: String) {
    chooseButton.setTitle(title, for: .normal)
  }
  
  func setupDataLabel(with title: String) {
    dataLabel.text = title
  }
}
