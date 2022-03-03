//
//  CloudManager.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

//import UIKit
//import CloudKit
//
//class CloudManager {
//
//    private static let privateCloudDataBase = CKContainer.default().privateCloudDatabase
//
//    static func saveDataToCloud(user: User) {//, clouser: @escaping (String) -> ()) {
//        let record = CKRecord(recordType: "User")
//        record.setValue(user.userID, forKey: "userID")
//        record.setValue(user.level, forKey: "level")
//        record.setValue(user.bestTime, forKey: "bestTime")
//        record.setValue(user.stars, forKey: "stars")
//        record.setValue(user.opened, forKey: "opened")
//        record.setValue(user.help, forKey: "help")
//
//        privateCloudDataBase.save(record) { (_, error) in
//            if let error = error { print(error); return }
////            if let newRecord = newRecord
////            {
////                clouser(newRecord.recordID.recordName)
////            }
//        }
//    }
//
//    static func updateDataInCloud(user: User) {
//        let recordID = CKRecord.ID(recordName: user.recordID)
//
//        privateCloudDataBase.fetch(withRecordID: recordID) { (record, error) in
//            if let record = record, error == nil {
//                DispatchQueue.main.async {
//                    record.setValue(user.bestTime, forKey: "bestTime")
//                    record.setValue(user.stars, forKey: "stars")
//                    record.setValue(user.opened, forKey: "opened")
//                    record.setValue(user.help, forKey: "help")
//
//                    privateCloudDataBase.save(record) { (_, error) in
//                        if let error = error { print(error.localizedDescription); return }
//                    }
//                }
//            }
//        }
//    }
//
//    static func fetchDataFromCloud(closure: @escaping (User) -> ()) {
//
//        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
//
//        query.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
//
//        privateCloudDataBase.perform(query, inZoneWith: nil) { (records, error) in
//            guard error == nil else { print(error!); return }
//            guard let records = records else { return }
//
//            records.forEach { (record) in
//                let newUserData = User(recordID: record.recordID.recordName,
//                                       userID: record.value(forKey: "userID") as! String,
//                                       level: record.value(forKey: "level") as! Int,
//                                       bestTime: record.value(forKey: "bestTime") as? Int,
//                                       stars: record.value(forKey: "stars") as! Int,
//                                       opened: record.value(forKey: "opened") as! Int,
//                                       help: record.value(forKey: "help") as! Int)
//                DispatchQueue.main.async {
//                    closure(newUserData)
//                }
//            }
//
//        }
//    }
//
//    static func deleteDataFromCloud(recordID: String) {
//        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
//        let queryOperation = CKQueryOperation(query: query)
//
//        queryOperation.desiredKeys = ["recordID"]
//        queryOperation.queuePriority = .veryHigh
//
//        queryOperation.recordFetchedBlock = { record in
//            if record.recordID.recordName == recordID {
//                privateCloudDataBase.delete(withRecordID: record.recordID) { (_, error) in
//                    if let error = error { print(error); return }
//                }
//            }
//
//            queryOperation.queryCompletionBlock = {_, error in
//                if let error = error { print(error); return }
//            }
//
//            privateCloudDataBase.add(queryOperation)
//        }
//    }
//}
