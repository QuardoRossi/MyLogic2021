//
//  StorageManager.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import Foundation

class StorageManager {
    // MARK: - Public Properties
    static let shared = StorageManager()
    
    // MARK: - Private Properties
    private var archiveGameURL: URL!
    private var archiveUserURL: URL!
    
    private let documentsDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask).first!
    
    // MARK: - Initializers
    private init() {
        archiveGameURL = documentsDirectory.appendingPathComponent("gameData").appendingPathExtension("plist")
        archiveUserURL = documentsDirectory.appendingPathComponent("userData").appendingPathExtension("plist")
    }
    
    // MARK: - Public Methods
    func saveDataGame(dataset: [Game]) {
        var dataCodable: Data

        do {
            try dataCodable = PropertyListEncoder().encode(dataset);
            try dataCodable.write(to: archiveGameURL, options: .noFileProtection)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }

    func fetchDataGame() -> [Game]? {
        var dataCodable: Data
        var dataFromBase: [Game]? = nil
        
        do {
            try dataCodable = Data(contentsOf: archiveGameURL)
            try dataFromBase = PropertyListDecoder().decode([Game].self,
                                                            from: dataCodable)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return dataFromBase
    }
    
    func saveDataUsers(users: [User]) {
        var dataCodable: Data
        
        do {
            try dataCodable = PropertyListEncoder().encode(users);
            try dataCodable.write(to: archiveUserURL, options: .noFileProtection)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateDataUserRecordID(user: User) {
        var dataset = fetchDataUser()!
        
        for data in dataset {
            if data.level == user.level {
                dataset[user.level - 1].recordID = user.recordID
            }
        }
        
        saveDataUsers(users: dataset)
    }

    func updateDataUser(user: User) {
        var dataset = fetchDataUser()!
        //var ulevel = 0
        
//        for dat in dataset {
//            print(dat.level)
//        }
        
        for data in dataset {
            if data.level == user.level {
                
                //ulevel = user.level
                //print("level: ")
                //print(user.level)
                //print("new best time: ")
                //print(user.bestTime)
                //print("Time bilo:")
                //print(dataset[user.level - 1].bestTime)
                
                dataset[user.level - 1].bestTime = user.bestTime
                dataset[user.level - 1].bestError = user.bestError
                dataset[user.level - 1].stars = user.stars
                dataset[user.level - 1].opened = user.opened
                dataset[user.level - 1].help = user.help
                
                //print("Time stalo:")
                //print(dataset[user.level - 1].bestTime)
            }
        }
        saveDataUsers(users: dataset)
        
        dataset = fetchDataUser()!
        //print("Time from memory:")
        //print(dataset[ulevel - 1].bestTime)
    }
    
    func fetchDataUser() -> [User]? {
        var dataCodable: Data
        var dataFromBase: [User]? = nil
        
        do {
            try dataCodable = Data(contentsOf: archiveUserURL)
            try dataFromBase = PropertyListDecoder().decode([User].self,
                                                            from: dataCodable)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return dataFromBase
    }
    
}
