//
//  Router.swift
//  MPCleantest
//
//  Created by Manish on 19/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class Router {
    static var shared = Router()
    var manager: Manager?
    func launch(on controller: UIViewController) {
        manager = Manager(self)
        manager?.lanuch(on: controller)
    }
}

extension Router: ManagerDelegate {
    func logout() {
         print("Method get called")
    }
}
