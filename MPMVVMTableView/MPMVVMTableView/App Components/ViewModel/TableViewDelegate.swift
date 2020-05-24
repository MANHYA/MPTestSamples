//
//  TableViewDelegate.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
   private let viewModel: ViewModel
   
   init(viewModel: ViewModel) {
       self.viewModel = viewModel
       super.init()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
