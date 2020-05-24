//
//  S.swift
//  sample
//
//  Created by Manish on 6/14/18.
//  Copyright © 2018 Aikya. All rights reserved.
//

import Foundation

public class GameCharactor: NSObject {

    @objc public func SomeFunction() -> String {
        
        let string = "m called from FrameWork"
        return string
    }
    
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}
