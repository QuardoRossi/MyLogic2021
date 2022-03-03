//
//  GameViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import UIKit
import AudioToolbox

enum Status: String {
    case prepare
    case active
    case update
}

struct Count: Codable {
    var date: Date //дата
    var time: Int //счетчик продолжительности игры
    var error: Int //счетчик ошибок пользователя
    var stars: Int //текущее количество звезд
}

extension Count {
    static func resetCurr() -> Count {
        Count(date: Date(), time: 0, error: 0, stars: 0)
    }
}

protocol GameViewControllerDelegate: AnyObject {
    func update()
}

class GameViewController: UIViewController, GameViewControllerDelegate {
    func update() {
        let level = game.level
        
        let games = StorageManager.shared.fetchDataGame() ?? []
        let users = StorageManager.shared.fetchDataUser() ?? []
        game = games[level]
        user = users[level]
        
        gameuser = GameUser(game: game, user: user)

        buildGame(status: .prepare)
    }
    
    
    //delegate for update levelsCVC (back button in GameVC)
    weak var delegate: LevelsViewControllerDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.update()
        SoundManager.shared.soundBackPlay()
    }
    
    // MARK: - IB Outlets
    @IBOutlet var viewElements: UIView!
    
    @IBOutlet var elementImageView11: UIImageView!
    @IBOutlet var elementImageView12: UIImageView!
    
    @IBOutlet var elementImageView21: UIImageView!
    @IBOutlet var elementImageView22: UIImageView!
    
    @IBOutlet var elementImageView31: UIImageView!
    @IBOutlet var elementImageView32: UIImageView!
    
    @IBOutlet var elementImageView41: UIImageView!
    @IBOutlet var elementImageView42: UIImageView!
    
    @IBOutlet var stackImageView1: UIStackView!
    @IBOutlet var stackImageView2: UIStackView!
    @IBOutlet var stackImageView3: UIStackView!
    @IBOutlet var stackImageView4: UIStackView!
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var equationStack: UIStackView!
    @IBOutlet var equationLabelLeft: UILabel!
    @IBOutlet var equationLabelRight: UILabel!
    @IBOutlet var elementImageView: UIImageView!
    
    @IBOutlet var gamesButton: UIButton!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    // MARK: - Properties
    var gameuser: GameUser!
    private var game: Game!
    private var user: User!
    private var gameTimer: Timer?
    private var status: Status = .prepare
    private var count = Count.resetCurr()
    private var example = Example.getBase()
    private var currentTask = 0 //счетчик урвнений
    private var operations : [Operation] = []
    private var figures : [Figure] = []
    private var besttime = "-"
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = gameuser.user
        game = gameuser.game
        
        prepareObserver()
        //prepareNavigationBar()
        prepareDesign()
        buildGame(status: status) //status.prepare
    }
    
    @IBAction func gameButton() {
        routeGame(for: nil)
        timeLabel.text = "0⏳"
        SoundManager.shared.soundStartPlay()
    }
    
    @IBAction func refreshGameButton(_ sender: UIBarButtonItem) {
        currentTask = 0
        buildGame(status: .prepare)
        SoundManager.shared.soundRefreshPlay()
//        routeGame(for: example.answer)
    }

    
    @IBAction func answerFourButtons(_ sender: UIButton) {
        if let answer = sender.titleLabel?.text {
            routeGame(for: Int(answer))
        } else { print("Error answer from button") }
    }
    
    // MARK: - Route game
    private func routeGame(for answer: Int?) {
        switch currentTask {
        case 0:
            status = .active
            buildGame(status: status)
        case 1...(game!.maxCountTask - 1):
            checkError(answer: answer ?? 0)
            status = .update
            buildGame(status: status)
            SoundManager.shared.soundAnswerPlay()
        case game!.maxCountTask:
            checkError(answer: answer ?? 0)
            currentTask = 0
            
            let resultGame = GameManager.shared.getResult(dataGame: game, dataUser: user, countset: count)
            
            SoundManager.shared.soundFinishPlay()
            
            performSegue(withIdentifier: "resultGame", sender: resultGame)
            
//            let dataUser = StorageManager.shared.fetchDataUser() ?? []
//            user = dataUser[gameuser.user.level - 1]
//
            DispatchQueue.main.async {
                self.buildGame(status: .prepare)
            }
        default: print("Default route game error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let rvc = segue.destination as? ResultViewController else { return }
        rvc.resultGame = sender as? ResultGame
        rvc.delegate = self
    }
    
    /// BACKEND ////////////////////////////////////////////////////////////////////
    
    // MARK: Build Game
    private func buildGame(status: Status) {
        buildGameData(for: status)
        buildGameTitle(for: status)
        buildGameVisibility(for: status)
    }
    
    private func buildGameData(for status: Status) { // MARK:
        switch status {
        case .prepare:

            let dataUser = StorageManager.shared.fetchDataUser() ?? []
//            print(dataUser)
            user = dataUser[gameuser.user.level - 1]

            
            count = .resetCurr() //обнуляем текущие параметры
            (operations, figures) = GameManager.shared.getElements(
                countOperations: game!.set
            )
            if user.bestTime != nil { besttime = String(user.bestTime!) } else { besttime = "-" }
            stopTimer()
        case .active, .update:
            //исключаем повтор уравнения
            let oldExample = example
            while example.leftNum == oldExample.leftNum {
                example = GameManager.shared.getExample(
                    game: game!,
                    operations: operations,
                    figures: figures)
            }
            
            currentTask += 1
            
            if status == .active { startTimer() }
        }
    }
    
    private func buildGameTitle(for status: Status) {
        switch status {
        case .prepare:
//            var bestTime = "-"
//            if user.bestTime != nil { bestTime = "\(NSString(format: "%.0f", user.bestTime!))"}
            
            changeTitleImageViews()
            changeTitle(label: timeLabel, text: "\(besttime)⏳")
            changeTitle(label: messageLabel, text: "Remember elements")
            navigationItem.title = "Level \(game.level)"
            
        case .active, .update:
            changeTitle(label: messageLabel, text: "\(currentTask) из \(game!.maxCountTask)")
            changeTitle(label: equationLabelLeft, text: "\(String(example.leftNum))")
            changeTitle(label: equationLabelRight, text: "\(String(example.rightNum))")
            elementImageView.image = UIImage(named: "\(example.figure.symbol)")
            
            var count = 0
            while count < 4 {
                changeTitle(button: answerButtons[count],
                            text: String(example.answers[count]))
                count += 1
            }
        }
    }
    
    
    private func buildGameVisibility(for status: Status) {
        switch status {
        case .prepare:
            changeVisibility(stack: equationStack, status: true) //hide
            changeVisibilityImageView(status: false) //show
            changeVisibility(buttons: answerButtons, status: true) //hide
            changeVisibility(buttons: [gamesButton], status: false) //show
        default: //.active:
            changeVisibility(stack: equationStack, status: false) //show
            changeVisibilityImageView(status: true) //hide
            changeVisibility(buttons: answerButtons, status: false) //show
            changeVisibility(buttons: [gamesButton], status: true) //hide
        }
    }
    
    // MARK: Build Game. Change Title
    private func changeTitle(label: UILabel, text: String) {
        label.text = text
    }
    
    private func changeTitleImageViews() {
        switch operations.count {
        case 2:
            elementImageView12.image = UIImage(named: operations[0].rawValue)
            elementImageView11.image = UIImage(named: figures[0].symbol)
            
            elementImageView22.image = UIImage(named: operations[1].rawValue)
            elementImageView21.image = UIImage(named: figures[1].symbol)
            
        case 3:
            elementImageView12.image = UIImage(named: operations[0].rawValue)
            elementImageView11.image = UIImage(named: figures[0].symbol)
            
            elementImageView22.image = UIImage(named: operations[1].rawValue)
            elementImageView21.image = UIImage(named: figures[1].symbol)
            
            elementImageView32.image = UIImage(named: operations[2].rawValue)
            elementImageView31.image = UIImage(named: figures[2].symbol)
            
        case 4:
            elementImageView12.image = UIImage(named: operations[0].rawValue)
            elementImageView11.image = UIImage(named: figures[0].symbol)
            
            elementImageView22.image = UIImage(named: operations[1].rawValue)
            elementImageView21.image = UIImage(named: figures[1].symbol)
            
            elementImageView32.image = UIImage(named: operations[2].rawValue)
            elementImageView31.image = UIImage(named: figures[2].symbol)
            
            elementImageView42.image = UIImage(named: operations[3].rawValue)
            elementImageView41.image = UIImage(named: figures[3].symbol)
        default: //1
        print("error")
        }
    }
    
    private func changeTitle(button: UIButton, text: String) {
        button.setTitle(text, for: .normal)
    }
    
    private func changeTitle(textField: UITextField, text: String) {
        textField.text = text
    }
    
    // MARK: Build Game. Change Visibility
    private func changeVisibility(stack: UIStackView, status: Bool) {
        stack.isHidden = status
    }
    
    
    private func changeVisibilityImageView(status: Bool) {
        if status == false {
            switch game!.set {
            case .one, .two:
                stackImageView1.isHidden = false
                stackImageView2.isHidden = false
                stackImageView3.isHidden = true
                stackImageView4.isHidden = true
            case .three:
                stackImageView1.isHidden = false
                stackImageView2.isHidden = false
                stackImageView3.isHidden = false
                stackImageView4.isHidden = true
            case .four:
                stackImageView1.isHidden = false
                stackImageView2.isHidden = false
                stackImageView3.isHidden = false
                stackImageView4.isHidden = false
            }
        } else {//false
            stackImageView1.isHidden = true
            stackImageView2.isHidden = true
            stackImageView3.isHidden = true
            stackImageView4.isHidden = true
        }
    }
    
    private func changeVisibility(buttons: [UIButton], status: Bool){
        for button in buttons {
            button.isHidden = status
        }
    }
    
    private func prepareDesign() {
        CustomLayer.customView(view: viewElements)
        CustomLayer.customStackView(view: equationStack)
        CustomLayer.customStackView(view: stackImageView1)
        CustomLayer.customStackView(view: stackImageView2)
        CustomLayer.customStackView(view: stackImageView3)
        CustomLayer.customStackView(view: stackImageView4)
        CustomLayer.customButtonTwo(buttons: answerButtons)
    }
    
    // MARK: Build Game. Check Error
    private func checkError(answer: Int) {
        if answer != example.answer {
            count.error += 1
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
        }
    }
    
    private func prepareNavigationBar() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    ///////////////////////////////////////////////////////////////
    
    // MARK: Timer
    private func startTimer() {
        gameTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    @objc
    private func updateTimer() {
        count.time += 1
        //timeLabel.text = "\(String(count.time))⏳"

        timeLabel.text = "\(String(count.time))⏳"
    }
    
    // MARK: Observer didEnterBackground
    private func prepareObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }
    
    @objc private func appDidEnterBackground() {
        switch status {
        case .active, .update:
            stopTimer()
            showAlert(with: "PAUSED", and: "")
        default: break
        }
    }
    
    // MARK: Alert Controller
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Resume", style: .default) { _ in
            self.startTimer()
        }
        alert.addAction(okAction)
        
        let restartAction = UIAlertAction(title: "New game", style: .default) { _ in
            self.buildGame(status: .prepare)
        }
        alert.addAction(restartAction)
        
        present(alert, animated: true)
    }
}



