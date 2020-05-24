//
//  ViewController.swift
//  MPRouterManagerDelegate
//
//  Created by Manish on 20/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func launch() {
        Router.shared.launch(on: self)
    }
}

