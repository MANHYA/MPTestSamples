//
//  PlayerViewController.swift
//  MPVideoPlayer
//
//  Created by Manish on 2/15/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, CustomViewDelagate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 211
    }
    
    
    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    customView.setVideoURL("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        customView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.playerLayer.frame = customView.videoView.bounds
        customView.playerLayer.videoGravity = AVLayerVideoGravity.resize
    }
    
    func customAction() {
        print("Orientation changed")
    }
}
