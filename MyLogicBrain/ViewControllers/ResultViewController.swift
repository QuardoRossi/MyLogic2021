//
//  ResultViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageLabelTwo: UIStackView!
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var viewElements: UIView!
    @IBOutlet var viewStars: UIView!
    
    @IBOutlet var dataStackOne: UIStackView!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var nextLevelButtoned: UIButton!
    
    @IBOutlet var starsImageView: UIImageView!
    
    @IBOutlet var timeOneLabel: UILabel!
    @IBOutlet var timeTwoLabel: UILabel!
    @IBOutlet var timeThreeLabel: UILabel!
    
    var resultGame: ResultGame!
    var coreFrameX: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDesign()
        dataToUI(segment: 0)
        
        if resultGame.message == "is passed" {
            nextLevelButtoned.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coreFrameX = starsImageView.frame.origin.x
        
        if resultGame.newStar == true { starsImageView.pulsate() }
        if resultGame.message == "New best time!" { timeLabel.pulsate() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SoundManager.shared.soundBackPlay()
    }

    weak var delegate: GameViewControllerDelegate?
    
    @IBAction func resultSegmentedControl(_ sender: UISegmentedControl) {
        dataToUI(segment: sender.selectedSegmentIndex)
    }
    
    @IBAction func retryLevelButton() {

        dismiss(animated: true)
    }
    
    @IBAction func nextLevelButton() {
        delegate?.update()

        dismiss(animated: true)
    }

    private func setStars(count: Int) {
        switch count {
        case 1:
            starsImageView.image = UIImage(named: "stars_1")
        case 2:
            starsImageView.image = UIImage(named: "stars_2")
        case 3:
            starsImageView.image = UIImage(named: "stars_3")
        default:
            starsImageView.image = UIImage(named: "stars_0")
        }
    }
    
    private func dataToUI(segment: Int) {
        levelLabel.text = String("Level \(resultGame.game.level) \(resultGame.message)")
        
        switch segment {
        case 0: //result
            viewElements.isHidden = false
            viewStars.isHidden = true
            
            messageLabel.text = "RESULT"
            
            let time = resultGame.count.time
            //timeLabel.text = String("Time: \(resultGame.count.time)")
            timeLabel.text = String("Time: \(time)")
            errorLabel.text = String("Error: \(resultGame.count.error)")
            
            setStars(count: resultGame.count.stars)
            
        case 1: //record
            var bestTime = "Time: -"
            var bestError = "Error: -"
            
            viewElements.isHidden = false
            viewStars.isHidden = true
            
            messageLabel.text = "RECORD"
            
            if resultGame.user.bestTime != nil {
                let time = resultGame.user.bestTime!
                bestTime = "Time: \(String(time))"
            }
            //if resultGame.user.bestTime != nil { bestTime = "Time: \(String(resultGame.user.bestTime!))"}
            if resultGame.user.bestError != nil { bestError = "Error: \(String(resultGame.user.bestError!))"}
            
            timeLabel.text = bestTime
            errorLabel.text = bestError
            
            setStars(count: resultGame.user.stars)
            
        case 2: //get stars
            viewElements.isHidden = true
            viewStars.isHidden = false
            
            let requirement = Requirement.getRequirement(level: resultGame.game.level)
            timeOneLabel.text = String(requirement[0].time)
            timeTwoLabel.text = String(requirement[1].time)
            timeThreeLabel.text = String(requirement[2].time)
            
        default:
            break
        }
    }
    
    private func startCoreAnimationView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
                        if self.starsImageView.frame.origin.x == self.coreFrameX { self.starsImageView.frame.origin.x -= 30
                        } else {
                            self.starsImageView.frame.origin.x += 30
                        }
        })
    }

    private func prepareDesign() {
        CustomLayer.customView(view: viewElements)
        CustomLayer.customView(view: viewStars)
        CustomLayer.customStackView(view: dataStackOne)
        CustomLayer.customStackView(view: messageLabelTwo)
        CustomLayer.customButtonTwo(buttons: buttons)
    }
    
}

extension UIImageView {
        func pulsate() {
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.fromValue = 0.95
            pulse.toValue = 1
            pulse.duration = 0.6
            pulse.autoreverses = true
            pulse.repeatCount = 30
            pulse.initialVelocity = 0.1
            pulse.damping = 0.1

            layer.add(pulse, forKey: nil)
        }
}

extension UILabel {
        func pulsate() {
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.fromValue = 0.95
            pulse.toValue = 1
            pulse.duration = 0.6
            pulse.autoreverses = true
            pulse.repeatCount = 30
            pulse.initialVelocity = 0.1
            pulse.damping = 0.1

            layer.add(pulse, forKey: nil)
        }
}
