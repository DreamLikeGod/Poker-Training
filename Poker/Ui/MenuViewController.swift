//
//  ViewController.swift
//  Poker
//
//  Created by Егор on 02.04.2023.
//

import UIKit

class MenuViewController: UIViewController {

    let data = Settings.shared
    
    func update() {
        self.view.backgroundColor = data.getData().1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnExit(_ sender: Any) {
        exit(0)
    }
    
}

