//
//  CustomView.swift
//  MPVideoPlayer
//
//  Created by Manish on 3/3/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


protocol CustomViewDelagate {
    func customAction()
}

class CustomView: UIView {
    
    let kCONTENT_XIB_NAME = "CustomView"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var durationLabel:UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: CustomSlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var menuTopView: UIView!
    @IBOutlet weak var menuBottomView: UIView!
    @IBOutlet weak var volume: UIButton!
    
    var playerLayer: AVPlayerLayer!
    var player = AVPlayer()
    var lblSliderValue: UILabel?
    fileprivate var isVideoPlaying = false
    fileprivate var timeObserver: AnyObject!
    fileprivate let menuContainer = UIView()
    
    fileprivate var videoUrl = URL(string: "http://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")! {
        didSet {
            let videoItem = AVPlayerItem(url: videoUrl)
            player.replaceCurrentItem(with: videoItem)
            player.currentItem?.addObserver(self, forKeyPath: "duration", options:[.new, .initial], context: nil)
        }
    }
    
    var delegate: CustomViewDelagate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        playerLayer = AVPlayerLayer(player: player)
        self.videoView.layer.insertSublayer(playerLayer, at: 0)
        self.addTimeObserver()

        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.triggerMenu (_:)))
        self.videoView.addGestureRecognizer(gesture)
        
        timeSlider.setThumbImage(UIImage(named:"sliderThumb"), for: .normal)
        timeSlider.setThumbImage(UIImage(named:"sliderThumb"), for: .highlighted)
        
        lblSliderValue?.frame.size = CGSize(width: 5, height: 5)
       // self.timeSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
    
    deinit {
        player.removeTimeObserver(timeObserver)
    }
    
    // Helpers
    func setVideoURL(_ url: String) {
        if let url = URL(string: url) {
            self.videoUrl = url
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = self.bounds
    }
    
    @objc func triggerMenu(_ btn: UIButton) {
        UIView.transition(with: menuTopView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.menuTopView.isHidden = !self.menuTopView.isHidden
        })
        UIView.transition(with: menuBottomView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.menuBottomView.isHidden = !self.menuBottomView.isHidden
        })
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self]  time in
            guard let currentItem = self!.player.currentItem else {return}
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentTimeLabel.text = self!.getTimeString(from: currentItem.currentTime())
        }) as AnyObject
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            durationLabel.text = getTimeString(from: (player.currentItem?.duration)!)
        }
    }
    
    // IBActions
    
    @IBAction func fullscreenButtonTapped(_ sender: AnyObject) {
        let currentOrientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        var value: Int?
        if currentOrientation == .landscapeRight {
            value = UIInterfaceOrientation.portrait.rawValue
        }else {
            value = UIInterfaceOrientation.landscapeRight.rawValue
        }
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        
        if delegate != nil {
            delegate?.customAction()
        }
    }
    
    @IBAction func volumeTapped(_ sender: UIButton) {
        if volumeSlider.value == 0 {
            volume.setImage(UIImage(named: "volume"), for: .normal)
            volumeSlider.value = 1
        }else {
            volume.setImage(UIImage(named: "mute"), for: .normal)
            volumeSlider.value = 0
        }
        player.volume = volumeSlider.value
    }
    
    @IBAction func videoChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        player.volume = sender.value
        if sender.value == 0 {
            volume.setImage(UIImage(named: "mute"), for: .normal)
        }else {
             volume.setImage(UIImage(named: "volume"), for: .normal)
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        if isVideoPlaying {
            player.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        }else {
            player.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
        isVideoPlaying = !isVideoPlaying
    }
    
    @IBAction func forwardPressed(_ sender: Any) {
        guard let duration = player.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5
        
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func backwardPressed(_ sender: Any) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5
        
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player.seek(to: time)
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

