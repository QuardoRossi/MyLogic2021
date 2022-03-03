//
//  ClosedViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 31.08.2021.
//

import UIKit

class ClosedLevelViewController: UIViewController {
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var labelStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareDesign()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SoundManager.shared.soundBackPlay()
    }
    
    private func prepareDesign() {
        CustomLayer.customView(view: dataView)
        CustomLayer.customStackView(view: labelStackView)
    }


}
