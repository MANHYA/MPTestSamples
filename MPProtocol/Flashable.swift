//
//  Flashable.swift
//  
//
//  Created by Manish on 6/21/18.
//

import UIKit

protocol Flashable {}

extension Flashable where Self: UIView {
    
    func flash() {
        UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseIn, animations: {
            if self.alpha == 1.0 {
                self.alpha = 0.0
            }else {
                self.alpha = 1.0
            }
        }) {(animationComplete) in
            if animationComplete == true {
                UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseIn, animations: {
                    if self.alpha == 0.0 {
                        self.alpha = 1.0
                    }else {
                        self.alpha = 0.0
                    }
                }, completion: nil)
            }
        }
    }
    
}
