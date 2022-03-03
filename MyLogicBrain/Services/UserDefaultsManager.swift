//
//  UserDefaultsManager.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    func fetchData(with key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        let firstLaunch = userDefaults.object(forKey: key) as? Bool
        
        let settings = firstLaunch == true ? true : false
        return settings
    }
    
    func saveData(with key: String, and setting: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(setting, forKey: key)
    }
}
