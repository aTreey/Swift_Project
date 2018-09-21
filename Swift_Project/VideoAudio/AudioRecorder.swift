//
//  AudioRecorder.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/6.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioRecorderDelegate {
    func recorderEnded(url: URL?, error: Error?)
}

class AudioRecorderManager: NSObject {
    enum State {
        case none
        case start
        case record
        case stop
        case pause
        case play
    }
    
    static var directory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var delegate: AudioRecorderDelegate?
    private var recorder: AVAudioRecorder?
    private var outputFileURL: URL
    var fileName: String?
    var filePath: String?
    var mp3FilePath: String?
    
    
    init(_ fileName: String) {
        filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        outputFileURL = URL(fileURLWithPath: AudioRecorderManager.directory).appendingPathComponent("\(fileName).caf")
        super.init()
        self.setupPermission()
    }
    
    
    
    // MARK: - Public

    func record() {
        guard let audioRecorder = recorder else { return }
        if (!audioRecorder.isRecording) {
            setSession(active: true)
            audioRecorder.record()
        } else {
            audioRecorder.stop()
        }
    }
    
    func record(time: TimeInterval) {
        guard let audioRecorder = recorder else { return }
        if !audioRecorder.isRecording {
            setSession(active: true)
            audioRecorder.record(forDuration: time)
        } else {
            audioRecorder.stop()
        }
    }
    
    
    /// 停止
    func stop() -> String {
        recorder?.stop()
        setSession(active: false)
        return outputFileURL.absoluteString
    }
    
    
    // MARK: - Private
    
    private func setupPermission() {
        let session = AVAudioSession.sharedInstance()
        session.requestRecordPermission { (granted) in
            if (granted) {
                self.setSessionPlayAndRecord()
            } else {
                print("User denied permission.")
            }
        }
    }
    
    private func setSessionPlayAndRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            setupRecorder()
        } catch let error {
            print("Set category error: \(error.localizedDescription).")
        }
    }
    
    
    private func setupRecorder() {
//        guard let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//        outputFileURL = paths.appendingPathComponent("test.m4a")
        let recordSetting: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 11025.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        //
        do {
            recorder = try AVAudioRecorder(url: outputFileURL, settings: recordSetting)
        } catch let outError {
            print("Error for recorder init: \(outError).")
        }
        recorder?.delegate = self
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
    }
    
    private func setSession(active: Bool) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(active)
        } catch let error {
            print("Set active error: \(error.localizedDescription).")
        }
    }
    
//    private func setFilePath(fileName: String) -> URL {
//
//    }
}

extension AudioRecorderManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.delegate?.recorderEnded(url: outputFileURL, error: nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        self.delegate?.recorderEnded(url: nil, error: error)
    }
}



// MARK: -
// MARK: -  AudioPlayerManager
class AudioPlayerManager: NSObject {
    private var player: AVAudioPlayer?
    func play(_ ulr: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: ulr)
        } catch let error {
            print(error)
        }
        player?.delegate = self
        player?.play()
    }
    
    func stop() {
        if let audioPlayer = player, audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
}

extension AudioPlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print(audioPlayerDidFinishPlaying)
        } else {
            print("audioPlayerDidFinishPlaying-flag = \(flag)")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if (error != nil) {
            print(error!)
        }
    }
}

