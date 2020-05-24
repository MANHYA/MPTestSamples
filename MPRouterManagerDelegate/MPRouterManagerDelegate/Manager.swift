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
    public init(_ delegate: ManagerDelegate? = nil) {
        self.delegate = delegate
    }
    public weak var delegate: ManagerDelegate?
    public var initialViewController: UINavigationController?
    public func lanuch(on controller: UIViewController) {
        let vc = BaseNavigationController()
        vc.modalPresentationStyle = .fullScreen
        vc.manager = self
        controller.present(vc, animated: true, completion: {
            self.initialViewController = vc
        })
    }
}
