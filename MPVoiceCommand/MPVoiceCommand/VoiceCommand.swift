//
//  MPVoiceCommand.swift
//  VoiceCommandWithShakeEvent
//
//  Created by Manish on 11/8/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import Foundation
import UIKit
import Speech

protocol SpeechRecogDelegate: class {
    func willStartRecording(type : Commandtype)
    func didFinishRecording(type : Commandtype, info: String)
}

extension UIViewController {
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            SpeechRecog.shared.checkSpeechAuthorizationStatus()
        }
    }
}

enum Commandtype {
    case pace
    case volume
    case next
    case prev
    case play
    case pause
    case stop
    case none
}

enum SpeechStatus {
    case ready
    case recognizing
    case unavailable
}

// MARK: Speech Recognition Setup

class SpeechRecog {
    
    init() {}

    weak var delegate: SpeechRecogDelegate?
    static let shared = SpeechRecog()

    private let audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "En-in"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    let array = [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150]
    let timeOutTime: TimeInterval =  3
    
    var message: String = "" {
        didSet {
            let stringArray = message.components(separatedBy: " ")
            message = stringArray.first ?? ""
        }
    }
    var type = Commandtype.none {
        didSet {
            self.setCommand(type: type)
        }
    }
    var status = SpeechStatus.ready {
        didSet {
            self.checkStatus(status: status)
        }
    }
        
    func checkSpeechAuthorizationStatus() {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .notDetermined:
            requestSpeechAuthorization()
        case .authorized:
            self.status = .ready
        case .denied, .restricted:
            self.status = .unavailable
        default:break
        }
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.checkSpeechAuthorizationStatus()
                default:
                    self.status = .unavailable
                }
            }
        }
    }
    
    func prepareRecording() {
        // Check if Player is playing in PlayerViewController
        self.type = .none
        self.willStartRecording()
        // Wait for voice request to finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){ [weak self] in
            do {
                try self?.startRecording()
            } catch(let error) {
                print("error is \(error.localizedDescription)")
            }
        }
    }
}

extension SpeechRecog {
    // MARK: Start recognizing voice
    func startRecording() throws {
        //Auto stop recording after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + timeOutTime) { [weak self] in
            if self?.status == .recognizing {
                self?.didFinishRecording(self?.message ?? "")
                self?.status = .unavailable
            }
        }
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        // Setup audio engine and speech recognizer
        guard let node = audioEngine.inputNode as AVAudioNode? else { return }
        node.removeTap(onBus: 0)
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request?.append(buffer)
        }
        
        // Prepare and start recording
        audioEngine.prepare()
        do {
            try audioEngine.start()
            self.status = .recognizing
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        request = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = request else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true

        if #available(iOS 13, *) {
            if speechRecognizer?.supportsOnDeviceRecognition ?? false{
                recognitionRequest.requiresOnDeviceRecognition = true
            }
        }

        // Analyze the speech
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [unowned self] result, error in
            guard let result = result else { return }
            guard error == nil else { print("recognition error : \(error.customMirror)");
                self.status = .unavailable
                return }
            if result.isFinal {
                self.status = .unavailable
            }
            guard result.bestTranscription.formattedString != self.message else {return}
            self.message = result.bestTranscription.formattedString
            print("got a new result: \(self.message)")
            self.status = .recognizing
        })
    }
    
    // MARK: Cancel voice recognition
    func cancelRecording() {
        self.audioEngine.stop()
        let node = self.audioEngine.inputNode
        node.removeTap(onBus: 0)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        self.message = ""
    }
    
    // MARK: Check voice commands
    func checkCommand(_ result: String) {
        switch message {
        case checkPace():
            self.type = .pace
        case "Increase":
            self.type = .volume
        case "Decrease":
            self.type = .volume
        case "Next":
            self.type = .next
        case "Previous":
            self.type = .prev
        case "Play":
            self.type = .play
        case "Pause":
            self.type = .pause
        case "Stop":
            self.type = .stop
        default:break
        }
    }
    
    func checkPace() -> String? {
        if let number = Int(message), array.contains(number) {
            return message
        }
        return nil
    }
    
    func checkStatus(status: SpeechStatus) {
        switch status {
        case .ready:
            self.prepareRecording()
            print("*************************")
        case .recognizing:
            self.checkCommand(self.message)
        case .unavailable:
            self.cancelRecording()
            print("*************************")
        }
    }
    
    // MARK: Set App Defaults
    func setCommand(type: Commandtype) {
        guard self.type != .none else {return}
        switch type {
        case .pace:
            setPace()
        case .volume:
            setVolume()
        default:break
        }
        didFinishRecording(self.message)
        self.status = .unavailable
    }
    
    func setPace() {
       // Set pace
    }

    func setVolume() {
        //  Sat volume
    }

    // MARK: Update App
    func didFinishRecording(_ msg: String = "") {
        self.delegate?.didFinishRecording(type: type, info: msg)
    }
    func willStartRecording() {
        self.delegate?.willStartRecording(type: type)
    }
}
