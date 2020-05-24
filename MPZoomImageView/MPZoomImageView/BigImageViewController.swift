//
//  BigImageViewController.swift
//  EEZoomableImageView
//
//  Created by Emre on 3.10.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController {
    
    let kPageTitle = "Big Photo"
    var parrotImage: UIImage?

    @IBOutlet weak var bigPhotoImageView: EEZoomableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bigPhotoImageView.image = parrotImage
    }
    @IBAction func moveBackToParentVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
