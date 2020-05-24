//
//  MPPickerTextField.swift
//  MPMVVMTableView
//
//  Created by Manish on 4/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class MPPickerTextField: UITextField, Flashable, Jitterable {

    public var didClickPickerField: (() -> Void)?

    @objc func pickerbuttonAction(_ sender: UIButton) {
        didClickPickerField?()
        self.jitter()
        self.flash()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPickerButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    private func addPickerButton() {
        let button = UIButton(type: .custom)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.pickerbuttonAction(_:)), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
}

