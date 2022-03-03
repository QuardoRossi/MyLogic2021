//
//  SoundManager.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 04.10.2021.
//

import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    var soundButton = AVAudioPlayer()
    var soundAnswer = AVAudioPlayer()
    var soundBack = AVAudioPlayer()
    var soundStart = AVAudioPlayer()
    var soundFinish = AVAudioPlayer()
    var soundRefresh = AVAudioPlayer()
    var soundAccess = AVAudioPlayer()
    
    func soundButtonPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundButton.stop()
            soundButton.play()
        }
    }
    
    func soundAnswerPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundAnswer.stop()
            soundAnswer.play()
        }
    }
    
    func soundBackPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundBack.stop()
            soundBack.play()
        }
    }
    
    func soundStartPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundStart.stop()
            soundStart.play()
        }
    }
    
    func soundFinishPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundFinish.stop()
            soundFinish.play()
        }
    }
    
    func soundRefreshPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundRefresh.stop()
            soundRefresh.play()
        }
    }
    
    func soundAccessPlay() {
        if UserDefaultsManager.shared.fetchData(with: "Sound") == true {
            soundAccess.stop()
            soundAccess.play()
        }
    }
    
    func loadSound() {
        do {
            try soundButton = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "button", ofType: "mp3")!))
            soundButton.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundAnswer = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "answer2", ofType: "mp3")!))
            soundAnswer.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundBack = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "back", ofType: "mp3")!))
            soundBack.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundStart = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "start2", ofType: "mp3")!))
            soundStart.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundFinish = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "start", ofType: "mp3")!))
            soundFinish.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundRefresh = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "answer42", ofType: "mp3")!))
            soundRefresh.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try soundAccess = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "access", ofType: "mp3")!))
            soundAccess.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}
