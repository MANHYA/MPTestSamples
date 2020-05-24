//
//  ViewController.swift
//  MPactivityIndicator
//
//  Created by Manish on 12/20/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func act1(_ sender: Any) {
        Activity.show()
    }
    @IBAction func act2(_ sender: Any) {
        Activity.show("dtvjhgjhgjg")
    }
    @IBAction func act3(_ sender: Any) {
        Activity.show(true)
    }
    @IBAction func act4(_ sender: Any) {
        Activity.show("ghfgfhfhfh", false)
    }
    @IBAction func act5(_ sender: Any) {
        Activity.dismiss()
    }
    

}

