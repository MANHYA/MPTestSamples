//
//  CustomSlider.swift
//  MPVideoPlayer
//
//  Created by Manish on 4/26/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import Foundation
import UIKit
import AVKit
public class CustomSlider: UISlider {
    
    var label: UILabel
    var labelXMin: CGFloat?
    var labelXMax: CGFloat?
    var labelText: ()->String = { "" }
    
    required public init?(coder aDecoder: NSCoder) {
        label = UILabel()
        super.init(coder: aDecoder)
        self.addTarget(self, action: Selector("onValueChanged:"), for: .valueChanged)
        
    }
    func setup(){
        labelXMin = frame.origin.x + 16
        labelXMax = frame.origin.x + self.frame.width - 14
        var labelXOffset: CGFloat = labelXMax! - labelXMin!
        var valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
        var valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
        var valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
        var labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
        label.frame = CGRect(x: labelXPos,y: self.frame.origin.y - 25, width: 200, height: 25)
        label.text = self.value.description
        self.superview!.addSubview(label)
        
    }
    func updateLabel(){
        label.text = labelText()
        var labelXOffset: CGFloat = labelXMax! - labelXMin!
        var valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
        var valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
        var valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
        var labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
        label.frame = CGRect(x: labelXPos - label.frame.width/2,y: self.frame.origin.y - 25, width: 200, height: 25)
        label.textAlignment = NSTextAlignment.center
        self.superview!.addSubview(label)
    }
    public override func layoutSubviews() {
        labelText = { String(format: "%.2f", self.value) }
        setup()
        updateLabel()
        super.layoutSubviews()
        super.layoutSubviews()
    }
    func onValueChanged(sender: CustomSlider){
        updateLabel()
    }
    func getTimeString(from time: CMTime) -> String {
        guard time.isNumeric == true else {return "00:00:00"}
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minuts = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minuts,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minuts,seconds])
        }
        
    }
}
