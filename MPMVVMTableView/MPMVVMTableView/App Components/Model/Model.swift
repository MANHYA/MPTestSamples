//
//  Model.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class InputItemModel {
    internal init(placeholder: String?, icon: UIImage? = nil, inputType: InputType = .textInput, id: InputFieldId, regex: String = "", maxChars: Int = 0, isEnable: Bool = true) {
        self.placeHolder = placeholder
        self.icon = icon
        self.inputType = inputType
        self.id = id
        self.regex = regex
        self.maxChars = maxChars
        self.isEnable = isEnable
    }
    
    var placeHolder: String?
    var icon: UIImage?
    var isEnable: Bool = true
    let inputType: InputType?
    var id: InputFieldId = .none
    var regex: String = ""
    var maxChars: Int?
}

public struct Item {
    public let title: String
    public let desc: String
}

enum InputType: String {
    case textInput
    case datePicker
    case amountPicker
}

enum InputFieldId: String {
    case amount
    case date
    case none
}
