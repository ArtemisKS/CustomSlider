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
  
  var presenter: FirstViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    presenter.tapOnData()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension FirstViewController: FirstViewProtocol {
  
  func setupButton(with title: String) {
    chooseButton.setTitle(title, for: .normal)
  }
}
