//
//  PlayerViewController.swift
//  MPAudioPlayer
//
//  Created by Manish on 2/13/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var trackId: Int = 0
    var library = MusicLibrary().library
    var audioPlayer = AVAudioPlayer()
    var isVideoPlaying = false
    
    func time(_ time: TimeInterval) -> String {
        let minutes = Int(time)/60
        let seconds = Int(time) - minutes * 60
        
        return String(format: "%02d:%02d", minutes,seconds) as String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    @objc func updateProgressView(_ timer: AnyObject) {
        if audioPlayer.isPlaying {
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
            currentTimeLabel.text = time(audioPlayer.currentTime)
        }
    }
    @IBAction func volumeChangd(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    @IBAction func playAction(sender: AnyObject) {
        if isVideoPlaying {
            audioPlayer.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        }else {
            audioPlayer.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
        isVideoPlaying = !isVideoPlaying
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }

    @IBAction func fastForwardAction(sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0
        if time > audioPlayer.duration {
            stopAction(sender: self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    
    @IBAction func rewindAction(sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0
        if time < 0 {
            stopAction(sender: self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    
    @IBAction func previousAction(sender: AnyObject) {
        if trackId != 0 || trackId > 0 {
            trackId -= 1
        }
        
        updateData()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    
    @IBAction func nextAction(sender: AnyObject) {
        
        if trackId == 0 || trackId < library.count {
            trackId += 1
        }
        
        updateData()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    
    func updateData() {
        
        let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.prepareToPlay()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateProgressView(_:)), userInfo: nil, repeats: true)
                DispatchQueue.main.async {
                    self.durationLabel.text = self.time(self.audioPlayer.duration)
                    self.progressView.setProgress(Float(self.audioPlayer.currentTime/self.audioPlayer.duration), animated: true)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
        let url = library[trackId]["image"]
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: url!)!) { //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.songTitleLabel.text = self.library[self.trackId]["title"]
                    self.artistLabel.text = self.library[self.trackId]["artist"]
                    self.coverImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
//    func downloadFileFromURL(){
//        let src = URL(string: library[trackId]["src"]!)
//        var downloadTask:URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: src!, completionHandler: { (url, response, error) in
//            self.updateData(url!)
//        })
//        downloadTask.resume()
//    }
}

