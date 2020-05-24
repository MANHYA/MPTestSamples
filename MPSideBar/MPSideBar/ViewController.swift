//
//  ViewController.swift
//  MPSideBar
//
//  Created by Manish on 10/28/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sideBarButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        barButtonItem.target = SWRevealViewController()
        barButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
        
        sideBarButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
    }
    @IBAction func sideBarButton(sender:UIButton) {
        if (self.revealViewController().frontViewPosition != FrontViewPosition.left) {
            sideBarButton.setImage(UIImage(named: "icons8-menu"), for: .normal)
        }else {
            sideBarButton.setImage(UIImage(named: "icons8-delete_sign"), for: .normal)
        }
    }

}


