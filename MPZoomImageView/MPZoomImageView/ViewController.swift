//
//  ViewController.swift
//  MPZoomImageView
//
//  Created by Manish on 4/18/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var zoomableImageView: EEZoomableImageView! {
        didSet {
            zoomableImageView.minZoomScale = 0.5
            zoomableImageView.maxZoomScale = 3.0
            zoomableImageView.resetAnimationDuration = 0.5
            
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//            zoomableImageView.isUserInteractionEnabled = true
//            zoomableImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "vc") as? BigImageViewController {
            vc3.parrotImage = tappedImage.image
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(vc3, animated: true, completion: nil)
        }
        
      //  performSegue(withIdentifier: "tap", sender: tappedImage.image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "tap", let bigImageVC = segue.destination as? BigImageViewController, let parrotImage = sender as? UIImage else { return }
        bigImageVC.parrotImage = parrotImage
    }
}

