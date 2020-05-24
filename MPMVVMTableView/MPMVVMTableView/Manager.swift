//
//  Manager.swift
//  MPCleantest
//
//  Created by Manish on 19/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

public protocol ManagerDelegate: class{
    func logout()
}

public class Manager {
    public weak var delegate: ManagerDelegate?
    public init(_ delegate: ManagerDelegate? = nil) {
        self.delegate = delegate
    }
    public func lanuch(on controller: UIViewController) {
        let vc = BaseNavigationController2()
        vc.modalPresentationStyle = .fullScreen
        vc.manager = self
        controller.present(vc, animated: true, completion: {})
    }
}

class BaseNavigationController2: UINavigationController {
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
}
