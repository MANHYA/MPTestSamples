//
//  MPPlayProgressView.swift
//  MPVideoPlayer
//
//  Created by Manish on 10/30/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import UIKit

class MPPlayProgressView: UIProgressView {


    override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        
        let size = CGSize.init(width: size.width, height: 2)
        return size
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
