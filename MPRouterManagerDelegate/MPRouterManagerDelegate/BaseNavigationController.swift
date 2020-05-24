//
//  BaseNavigationController.swift
//  MPRouterManagerDelegate
//
//  Created by Manish on 20/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    var manager: Manager?
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        self.viewControllers = [vc]
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.tintColor = .red
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
