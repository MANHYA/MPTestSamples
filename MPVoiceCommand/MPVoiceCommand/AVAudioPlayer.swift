//
//  AVAudioPlayer.swift
//  MPVoiceCommand
//
//  Created by Manish on 24/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import Foundation
import AVKit

class Player {
    static var player: AVAudioPlayer?
    static func playFrom(_ file: String) {
        
        guard let url = Bundle.main.url(forResource: file, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
