//
//  Game.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

import Foundation

struct Game: Codable {
    let level: Int
    let set: SetCount
    let operands: [String : Int]
    let maxCountTask: Int
}

struct User: Codable, Equatable {
    var recordID = ""
    var userID = UUID().uuidString
    let level: Int
    var bestTime: Int?
    var bestError: Int?
    var stars: Int
    var opened: Int // 0 - close, 1 - open
    var help: Int //purchase // 0 - close, 1 - open
}

struct GameUser {
    let game: Game
    let user: User
}

extension Game {
    
    static func getBaseDataUser() -> [User] {
        return [
            User(userID: UUID().uuidString,
                 level: 1,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 1,
                 help: 1),
            User(userID: UUID().uuidString,
                 level: 2,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 1),
            User(userID: UUID().uuidString,
                 level: 3,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 1),
            User(userID: UUID().uuidString,
                 level: 4,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 1),
            User(userID: UUID().uuidString,
                 level: 5,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 1),
            User(userID: UUID().uuidString,
                 level: 6,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 1),
            
            User(userID: UUID().uuidString,
                 level: 7,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 8,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 9,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 10,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            
            User(userID: UUID().uuidString,
                 level: 11,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 12,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 13,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 14,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            
            User(userID: UUID().uuidString,
                 level: 15,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 16,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 17,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 0,
                 help: 0),
            User(userID: UUID().uuidString,
                 level: 18,
                 bestTime: nil,
                 bestError: nil,
                 stars: 0,
                 opened: 1,
                 help: 0)
        ]
    }
    
    static func getBaseDataGame() -> [Game] {
        return [
            Game(level: 1,
                 set: .one,
                 operands: ["left" : 1, "right" : 1],
                 maxCountTask: 20),
            Game(level: 2,
                 set: .one,
                 operands: ["left" : 2, "right" : 1],
                 maxCountTask: 20),
            Game(level: 3,
                 set: .one,
                 operands: ["left" : 2, "right" : 2],
                 maxCountTask: 10),
            Game(level: 4,
                 set: .one,
                 operands: ["left" : 3, "right" : 1],
                 maxCountTask: 10),
            Game(level: 5,
                 set: .one,
                 operands: ["left" : 3, "right" : 2],
                 maxCountTask: 5),
            Game(level: 6,
                 set: .one,
                 operands: ["left" : 3, "right" : 3],
                 maxCountTask: 5),
            
            Game(level: 7,
                 set: .two,
                 operands: ["left" : 1, "right" : 1],
                 maxCountTask: 20),
            Game(level: 8,
                 set: .two,
                 operands: ["left" : 2, "right" : 1],
                 maxCountTask: 10),
            Game(level: 9,
                 set: .two,
                 operands: ["left" : 2, "right" : 2],
                 maxCountTask: 5),
            Game(level: 10,
                 set: .two,
                 operands: ["left" : 3, "right" : 1],
                 maxCountTask: 5),
            
            Game(level: 11,
                 set: .three,
                 operands: ["left" : 1, "right" : 1],
                 maxCountTask: 20),
            Game(level: 12,
                 set: .three,
                 operands: ["left" : 2, "right" : 1],
                 maxCountTask: 10),
            Game(level: 13,
                 set: .three,
                 operands: ["left" : 2, "right" : 2],
                 maxCountTask: 5),
            Game(level: 14,
                 set: .three,
                 operands: ["left" : 3, "right" : 1],
                 maxCountTask: 5),
            
            Game(level: 15,
                 set: .four,
                 operands: ["left" : 1, "right" : 1],
                 maxCountTask: 20),
            Game(level: 16,
                 set: .four,
                 operands: ["left" : 2, "right" : 1],
                 maxCountTask: 10),
            Game(level: 17,
                 set: .four,
                 operands: ["left" : 2, "right" : 2],
                 maxCountTask: 5),
            Game(level: 18,
                 set: .four,
                 operands: ["left" : 3, "right" : 1],
                 maxCountTask: 5)
        ]
    }
}
