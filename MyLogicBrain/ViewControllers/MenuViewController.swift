//
//  MenuViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import UIKit
import StoreKit


class MenuViewController: UIViewController {
    var firstStart = true
    
    @IBOutlet var buttonGame: UIButton!
    @IBOutlet var buttonRules: UIButton!
    @IBOutlet var imageViewSound: UIImageView!
    
    @IBOutlet var starsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDesign()
        checkFirstLaunch()
        SoundManager.shared.loadSound()
        
        if UserDefaultsManager.shared.fetchData(with: "Sound") == false {
            imageViewSound.image = UIImage(named: "soundOff")
        }
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstStart == true {
            firstStart = false
        } else {
            SoundManager.shared.soundBackPlay()
        }
        loadCountStars()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    @IBAction func playButton() {
        SoundManager.shared.soundButtonPlay()
    }
    
    @IBAction func aboutButton() {
        SoundManager.shared.soundButtonPlay()
        performSegue(withIdentifier: "about", sender: Any?.self)
    }
    
    @IBAction func changeSound() {
        let sound = UserDefaultsManager.shared.fetchData(with: "Sound")
        
        if sound == true {
            UserDefaultsManager.shared.saveData(with: "Sound", and: false)
            imageViewSound.image = UIImage(named: "soundOff")
        } else {
            UserDefaultsManager.shared.saveData(with: "Sound", and: true)
            imageViewSound.image = UIImage(named: "soundOn")
        }
    }
    
    
    private func loadCountStars() {
        if let users = StorageManager.shared.fetchDataUser() {
            var stars = 0
            
            for user in users {
                stars += user.stars
            }
            
            starsLabel.text = "\(String(stars))/54"
        }
    }
    
    func checkFirstLaunch() {
        let firstLaunch = UserDefaultsManager.shared.fetchData(with: "First Launch")
        
        if firstLaunch != true {
            //приложение запущено впервые, записываем базовые параметры игры
            UserDefaultsManager.shared.saveData(with: "First Launch", and: true)
            UserDefaultsManager.shared.saveData(with: "Sound", and: true)
            
            formObjectsFirstLaunch()
        }
    }
    
    private func formObjectsFirstLaunch() {
        let gameData = Game.getBaseDataGame()
        StorageManager.shared.saveDataGame(dataset: gameData)
        
        let users = Game.getBaseDataUser()
        StorageManager.shared.saveDataUsers(users: users)
        
        loadCountStars()
    }
    
    private func prepareDesign() {
        CustomLayer.addVerticalGradient(from: view.bounds) { grad in
            view.layer.insertSublayer(grad, at: 0)
        }
        CustomLayer.customButton(buttons: [buttonGame, buttonRules])
    }
}
