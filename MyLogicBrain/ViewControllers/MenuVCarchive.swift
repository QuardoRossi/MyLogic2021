////
////  MenuViewController.swift
////  MyLogicBrain
////
////  Created by Михаил Кожанов on 28.01.2021.
////
//
//import UIKit
//import StoreKit
//
//class MenuViewController: UIViewController {
//    @IBOutlet var viewCloud: UIView!
//
//    @IBOutlet var buttonGame: UIButton!
//    @IBOutlet var buttonRules: UIButton!
//
//    @IBOutlet var myLogicImageView: UIImageView!
//
//    @IBOutlet var progressLabel: UILabel!
//    @IBOutlet var starsLabel: UILabel!
//    @IBOutlet var effectView: UIVisualEffectView!
//    @IBOutlet var activityCloud: UIActivityIndicatorView!
//    @IBOutlet var messageOfStatus: UILabel!
//
//    private var progress = 0
//    private var gameTimer: Timer?
//    private var countTimer = 0
//
//    private var usersFromCloud: [User] = []
//
//    private var usersRecordID: [User] = []
//    private var countRecordId = 0 {
//        didSet {
//            if usersRecordID.count == 18 {
//                for user in usersRecordID {
//                    StorageManager.shared.updateDataUserRecordID(user: user)
//                }
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        prepareDesign()
//        checkFirstLaunch()
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        loadCountStars()
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
//
//    @IBAction func aboutButton() {
//        performSegue(withIdentifier: "about", sender: Any?.self)
//    }
//
//    private func loadCountStars() {
//        if let users = StorageManager.shared.fetchDataUser() {
//            var stars = 0
//
//            for user in users {
//                stars += user.stars
//            }
//
//            starsLabel.text = "\(String(stars))/54"
//        }
//    }
//
//    func checkFirstLaunch() {
//        let firstLaunch = UserDefaultsManager.shared.fetchData(with: "First Launch")
//
//        if firstLaunch != true {
//            //приложение запущено впервые, записываем базовые параметры игры
//            UserDefaultsManager.shared.saveData(with: "First Launch", and: true)
//            //UserDefaultsManager.shared.saveData(with: "Sound", and: true)
//
//            formObjectsFirstLaunch()
//        }
//        else {
//
//            if let users = StorageManager.shared.fetchDataUser() {
//                guard users.first?.recordID != "" else { return }
//                for user in users {
//                    CloudManager.updateDataInCloud(user: user)
//                }
//            }
//        }
//    }
//
//    private func formObjectsFirstLaunch() {
//        activityCloud.startAnimating()
//        effectView.isHidden = false
//        myLogicImageView.isHidden = true
//
//        let gameData = Game.getBaseDataGame()
//        StorageManager.shared.saveDataGame(dataset: gameData)
//
//        startTimer()
//
//        CloudManager.fetchDataFromCloud { (userCloud) in
//            self.usersFromCloud.append(userCloud)
//
//            switch self.usersFromCloud.count {
//            case 0: self.progress = 0
//            case 9: self.progress = 50
//            case 18: self.progress = 100
//            default: self.progress += 4
//            }
//        }
//    }
//
//    private func stopLoadingCloud() {
//        loadCountStars()
//
//        self.activityCloud.stopAnimating()
//        self.effectView.isHidden = true
//        self.myLogicImageView.isHidden = false
//    }
//
//    // MARK: Timer
//    private func startTimer() {
//        gameTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
//
//    private func stopTimer() {
//        gameTimer?.invalidate()
//        gameTimer = nil
//    }
//
//    @objc
//    private func updateTimer() {
//        let users = StorageManager.shared.fetchDataUser() ?? Game.getBaseDataUser()
//
//        StorageManager.shared.saveDataUsers(users: users)
//        countTimer += 1
//
//        if progress < 100 {
//            switch countTimer {
//            case 1: progressLabel.text = "23%"
//            case 2: progressLabel.text = "67%"
//            case 3:
////                messageOfStatus.text = "No data found in iCloud"
//            progressLabel.text = "100%"
//                if usersFromCloud.count == 0 {
//                    for user in users {
//                        CloudManager.saveDataToCloud(user: user)
//                    }
//                }
//            case 4: stopLoadingCloud()
//            case 20:
//                CloudManager.fetchDataFromCloud { (user) in
//                        self.usersRecordID.append(user)
//                        self.countRecordId += 1
//                }
//                stopTimer()
//            default:
//                print("")
//            }
//        }
//
//        //Users From Cloud To Local Base
//        if progress == 100 {
//            switch countTimer {
//            case 2: progressLabel.text = "13%"
//            case 4: progressLabel.text = "37%"
//            case 7: progressLabel.text = "51%"
//            case 9: progressLabel.text = "63%"
//            case 10: progressLabel.text = "85%"
//            case 11: progressLabel.text = "100%"
//            case 12:
//                StorageManager.shared.saveDataUsers(users: usersFromCloud)
//                stopLoadingCloud()
//                stopTimer()
//            default:
//                print("")
//            }
//        }
//    }
//
//    private func prepareDesign() {
//        CustomLayer.addVerticalGradient(from: view.bounds) { grad in
//            viewCloud.layer.insertSublayer(grad, at: 0)
//        }
//        CustomLayer.addVerticalGradient(from: view.bounds) { grad in
//            view.layer.insertSublayer(grad, at: 0)
//        }
//        CustomLayer.customButton(buttons: [buttonGame, buttonRules])
//    }
//}
