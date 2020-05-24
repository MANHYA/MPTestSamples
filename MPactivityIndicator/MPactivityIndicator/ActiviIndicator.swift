//
//  ActiviIndicator.swift
//  Aspen
//
//  Created by Manish on 1/25/18.
//  Copyright © 2018 apple_aikya. All rights reserved.
//

import Foundation
import SKActivityIndicatorView

class Activity: NSObject {
    
    // MARK: - Initialization
    private override init() {
        super.init()
        
        // default is darkGray
        SKActivityIndicator.spinnerColor(UIColor.darkGray)
        
        
        // default is black
        SKActivityIndicator.statusTextColor(UIColor.black)
        
        
        // default is System Font
        let myFont = UIFont(name: "AvenirNext-DemiBold", size: 18)
        SKActivityIndicator.statusLabelFont(myFont!)
        
        // ActivityIndicator Styles: choose and set one of four.
        //SKActivityIndicator.spinnerStyle(.defaultSpinner)
        SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
        //SKActivityIndicator.spinnerStyle(.spinningCircle)
        //SKActivityIndicator.spinnerStyle(.spinningHalfCircles)
        
    }

    //Show only ActivityIndicatorView without status message:
    class func show() {
        SKActivityIndicator.show("", userInteractionStatus: false)
    }
    
    //Display ActivityIndicatorView with status message:
    class func show(_ message: String) {
        SKActivityIndicator.show(message)
    }

    //Display ActivityIndicatorView with status message and user interaction status:
    class func show(_ message: String, _ userInteraction: Bool) {
        SKActivityIndicator.show(message, userInteractionStatus: userInteraction)
    }
    
    //Display ActivityIndicatorView with user interaction status:
    class func show(_ userInteraction: Bool) {
        SKActivityIndicator.show("", userInteractionStatus: userInteraction)
    }

    //Hide ActivityIndicatorView:
    class func dismiss() {
        SKActivityIndicator.dismiss()
    }  
}

