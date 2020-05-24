//
//  ViewController2.swift
//  MPMVVMTableView
//
//  Created by Manish on 19/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    weak var managerDelegate: ManagerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func action() {
        if let vc = self.navigationController as? BaseNavigationController2 {
            vc.manager?.delegate?.logout()
        }
    }
}
