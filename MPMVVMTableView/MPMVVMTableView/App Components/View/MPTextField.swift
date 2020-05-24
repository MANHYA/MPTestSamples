//
//  MPTextField.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class MPTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func firstTextFieldplaceHolder() {
        let placeholderString = NSAttributedString(string: "",  attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        self.attributedPlaceholder = placeholderString
    }
}
