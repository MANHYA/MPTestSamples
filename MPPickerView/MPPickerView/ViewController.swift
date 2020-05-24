//
//  ViewController.swift
//  MPPickerView
//
//  Created by Manish on 2/12/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerTextField : UITextField!
    
    let salutations = ["", "Mr.", "Ms.", "Mrs."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTextField.loadDropdownData(data: salutations)
        pickerTextField.loadDropdownData(data: salutations, selectionHandler: salutations_onSelect(_:))
    }
    
    func salutations_onSelect(_ selectedText: String) {
        if selectedText == "" {
            print("Hello World")
        } else if selectedText == "Mr." {
            print("Hello Sir")
        } else {
            print("Hello Madame")
        }
    }
}

