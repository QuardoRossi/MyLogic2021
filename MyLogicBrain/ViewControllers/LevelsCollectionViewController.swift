//
//  LevelsCollectionViewController.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import UIKit

//delegate for update levelsCVC (back button in GameVC)
protocol LevelsViewControllerDelegate: AnyObject { //class
    func update()
}

class LevelsCollectionViewController: UICollectionViewController, LevelsViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //delegate for update levelsCVC (back button in GameVC)
        guard let destination = segue.destination as? GameViewController else { return }
        destination.delegate = self

        guard let gvc = segue.destination as? GameViewController else { return }
        gvc.gameuser = (sender as? GameUser)!
    }
    
    //delegate for update levelsCVC (back button in GameVC)
    func update() {
        user = StorageManager.shared.fetchDataUser() ?? []
        collectionView.reloadData()
    }
    
    //for layout
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    var game: [Game] = []
    var user: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDesign()
        
        let gameBase = Game.getBaseDataGame()
        let userBase = Game.getBaseDataUser()
        
        game = StorageManager.shared.fetchDataGame() ?? gameBase
        user = StorageManager.shared.fetchDataUser() ?? userBase
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return game.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "levelCell", for: indexPath) as! CustomCollectionViewCell
        
//        let operands = "\(String(game[indexPath.row].operands["left"]!)) \(String(game[indexPath.row].operands["right"]!))"
          
        cell.backgroundColor = .white
        cell.levelLabel.text = String(game[indexPath.row].level)
        
//        switch String(game[indexPath.row].set.rawValue) {
//        case "+, -": cell.setImageView.image = UIImage(named: "var_1_1")
//        case "x, ÷": cell.setImageView.image = UIImage(named: "var_1_2")
//        case "+, -, x": cell.setImageView.image = UIImage(named: "var_1_3")
//        case "+, -, x, ÷": cell.setImageView.image = UIImage(named: "var_1_4")
//        default: cell.setImageView.image = UIImage(named: "error")
//        }
//
//        switch operands {
//        case "1 1": cell.operandsImageView.image = UIImage(named: "op_11")
//        case "2 1": cell.operandsImageView.image = UIImage(named: "op_21")
//        case "2 2": cell.operandsImageView.image = UIImage(named: "op_22")
//        case "3 1": cell.operandsImageView.image = UIImage(named: "op_31")
//        case "3 2": cell.operandsImageView.image = UIImage(named: "op_32")
//        case "3 3": cell.operandsImageView.image = UIImage(named: "op_33")
//        default: cell.operandsImageView.image = UIImage(named: "error")
//        }
        
        switch user[indexPath.row].opened {
        case 1: //opened
            cell.zamokLabel.image = UIImage(named: "zamok_open")
        default: //0 close
            cell.zamokLabel.image = UIImage(named: "zamok_closed")
        }
        
        switch user[indexPath.row].stars {
        case 1: cell.starsImageView.image = UIImage(named: "stars_1")
        case 2: cell.starsImageView.image = UIImage(named: "stars_2")
        case 3: cell.starsImageView.image = UIImage(named: "stars_3")
        default: cell.starsImageView.image = UIImage(named: "stars_0")
        }
        
        CustomLayer.customView(view: cell.customStackView)
        
        cell.layer.backgroundColor = CGColor(red: 256, green: 256, blue: 256, alpha: 0)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameuser = GameUser(game: game[indexPath.row], user: user[indexPath.row])
        
        if gameuser.user.opened == 0 { //close
            SoundManager.shared.soundAccessPlay()
            performSegue(withIdentifier: "closedLevels", sender: gameuser)
        } else {// 1 open
            SoundManager.shared.soundButtonPlay()
            performSegue(withIdentifier: "gameSegue", sender: gameuser)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    private func prepareDesign() {
        CustomLayer.customBackground(layer: collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "transparent2.jpg"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let gvc = segue.destination as? GameViewController else { return }
//        gvc.game = (sender as? Game)!
//    }
}

//Custom view cell
class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var customStackView: UIView!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var starsImageView: UIImageView!
    @IBOutlet var zamokLabel: UIImageView!
    
}

//Layout prepare
extension LevelsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 92)//widthPerItem/1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}






/*
// MARK: UICollectionViewDelegate

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    return true
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    return false
}

override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    return false
}

override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

}
*/
*/
