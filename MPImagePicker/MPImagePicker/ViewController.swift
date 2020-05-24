//
//  ViewController.swift
//  MPImagePicker
//
//  Created by Manish on 1/23/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var picker : ImagePicker?
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func uploadImageButtonAction(_ sender: Any) {
        self.picker = ImagePicker(view: self.view, viewController: self) { (image) in
            print("My image picked")
            self.imageView.image = image
            //self.avatarButton.setImage(image, for: .normal)
            //self.avatarButton.contentMode = UIView.ContentMode.scaleAspectFit
        }
        
        self.picker?.showImagePicker()
    }

}

