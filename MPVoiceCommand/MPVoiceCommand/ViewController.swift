//
//  ViewController.swift
//  MPVoiceCommand
//
//  Created by Manish on 23/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transcribedText:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15)
        view.backgroundColor = .gray
        return view
    }()
    
    weak var speechRecogDelegate: SpeechRecogDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpeechRecog.shared.delegate = self
        
        self.view.addSubview(transcribedText)
        NSLayoutConstraint.activate(
            [transcribedText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
             transcribedText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             transcribedText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             transcribedText.heightAnchor.constraint(equalToConstant: 200),
             transcribedText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
}

extension ViewController: SpeechRecogDelegate {
    func willStartRecording(type of: Commandtype) {
        transcribedText.text = ""
        Player.playFrom("request")
    }
    
    func didFinishRecording(type: Commandtype) {
        var note: String = ""
        switch type {
        case .pace:
            note = "Pace saved"
            Player.playFrom("bpm")
        case .volume:
            note = "Volume saved"
            Player.playFrom("volume")
        case .next:
            note = "Next called"
        case .prev:
            note = "previous called"
        case .play:
            note = "Play called"
        case .pause:
            note = "Pause called"
        case .stop:
            note = "Stopn called"
        case .none:
            note = "Command not found"
            Player.playFrom("command")
        }
        transcribedText.text = "type: \(type)   message: \(note)"
    }
}
