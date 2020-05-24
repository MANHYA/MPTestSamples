//
//  SWRVCTableViewCell.swift
//  MPSideBar
//
//  Created by Manish on 10/29/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import UIKit

class SWRVCTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
