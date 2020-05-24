//
//  ViewController.swift
//  MPDynamicLabelInScrollView
//
//  Created by Manish on 1/22/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

// change the view height constarints priority to 250.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
