//
//  PurchaseViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 31.08.2021.
//

import UIKit

class PurchaseViewController: UIViewController {

    @IBOutlet var selectedAll: UIImageView!
    @IBOutlet var selectAll: UIImageView!
    
    @IBOutlet var unselectedOne: UIImageView!
    @IBOutlet var unselectOne: UIImageView!
    
    @IBOutlet var labelStackView: UIStackView!
    
    @IBOutlet var continueButtoned: UIButton!
    
    @IBOutlet var dataView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareDesign()
    }
    
    @IBAction func continueButton() {
        
    }
    
    @IBAction func purchaseAllButton() {
        selectedAll.image = UIImage(named: "purchase_selected")
        selectAll.image = UIImage(named: "purchase_select")
        
        unselectedOne.image = UIImage(named: "purchase_unselected")
        unselectOne.image = UIImage(named: "purchase_unselect")
    }
    
    @IBAction func purchaseOneButton() {
        selectedAll.image = UIImage(named: "purchase_unselected")
        selectAll.image = UIImage(named: "purchase_unselect")
        
        unselectedOne.image = UIImage(named: "purchase_selected")
        unselectOne.image = UIImage(named: "purchase_select")
    }
    
    private func prepareDesign() {
        CustomLayer.customView(view: dataView)
        CustomLayer.customStackView(view: labelStackView)
        CustomLayer.customButtonTwo(buttons: [continueButtoned])
    }


}
