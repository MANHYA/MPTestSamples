//
//  PickerItemModel.swift
//  MPMVVMTableView
//
//  Created by Manish on 5/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class PickerItemModel {
    
    var title: String
    var description: String
    var isEnable: Bool = true
    
    internal init(title:String, description:String, isEnable: Bool = true) {
    self.title = title
    self.description = description
    self.isEnable = isEnable
    }
}
