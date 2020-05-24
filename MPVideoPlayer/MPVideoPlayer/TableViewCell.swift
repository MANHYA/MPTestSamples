//
//  TableViewCell.swift
//  MPTableViewVideoPLayer
//
//  Created by Manish on 9/8/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, CustomViewDelagate {
    
    func customAction() {
        print("working,......")
    }

    @IBOutlet weak var customView: CustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    customView.setVideoURL("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        customView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
