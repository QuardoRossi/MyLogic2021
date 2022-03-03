//
//  Requirement.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

struct Requirement {
    var stars: Int //счетчик звезд
    var error: Int //счетчик ошибок пользователя
    var time: Int //счетчик продолжительности игры
}

extension Requirement {
    static func getRequirement(level: Int) -> [Requirement] {
        switch level {
        case 1:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 75),
                Requirement(stars: 2, error: 1, time: 35),
                Requirement(stars: 3, error: 0, time: 25)
            ]
        case 2:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 85),
                Requirement(stars: 2, error: 1, time: 45),
                Requirement(stars: 3, error: 0, time: 35)
            ]
        case 3:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 80),
                Requirement(stars: 2, error: 1, time: 40),
                Requirement(stars: 3, error: 0, time: 30)
            ]
        case 4:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 75),
                Requirement(stars: 2, error: 1, time: 35),
                Requirement(stars: 3, error: 0, time: 25)
            ]
        case 5:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 70),
                Requirement(stars: 2, error: 1, time: 30),
                Requirement(stars: 3, error: 0, time: 20)
            ]
        case 6:
            return [
                //Requirement(stars: 0, error: 3, time: 120),
                Requirement(stars: 1, error: 2, time: 80),
                Requirement(stars: 2, error: 1, time: 40),
                Requirement(stars: 3, error: 0, time: 30)
            ]
        case 7:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 75),
                Requirement(stars: 2, error: 1, time: 35),
                Requirement(stars: 3, error: 0, time: 25)
            ]
        case 8:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 85),
                Requirement(stars: 2, error: 1, time: 45),
                Requirement(stars: 3, error: 0, time: 35)
            ]
        case 9:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 90),
                Requirement(stars: 2, error: 1, time: 50),
                Requirement(stars: 3, error: 0, time: 40)
            ]
        case 10:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 85),
                Requirement(stars: 2, error: 1, time: 45),
                Requirement(stars: 3, error: 0, time: 35)
            ]
        case 11:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 90),
                Requirement(stars: 2, error: 1, time: 50),
                Requirement(stars: 3, error: 0, time: 40)
            ]
        case 12:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 110),
                Requirement(stars: 2, error: 1, time: 70),
                Requirement(stars: 3, error: 0, time: 50)
            ]
        case 13:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 130),
                Requirement(stars: 2, error: 1, time: 80),
                Requirement(stars: 3, error: 0, time: 60)
            ]
        case 14:
            return [
                //Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 70),
                Requirement(stars: 2, error: 1, time: 30),
                Requirement(stars: 3, error: 0, time: 20)
            ]
        case 15:
            return [
               // Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 90),
                Requirement(stars: 2, error: 1, time: 50),
                Requirement(stars: 3, error: 0, time: 40)
            ]
        case 16:
            return [
               // Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 90),
                Requirement(stars: 2, error: 1, time: 55),
                Requirement(stars: 3, error: 0, time: 45)
            ]
        case 17:
            return [
               // Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 95),
                Requirement(stars: 2, error: 1, time: 60),
                Requirement(stars: 3, error: 0, time: 50)
            ]
        case 18:
            return [
               // Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 2, time: 90),
                Requirement(stars: 2, error: 1, time: 50),
                Requirement(stars: 3, error: 0, time: 40)
            ]
        default: // 0
            return [
               // Requirement(stars: 0, error: 8, time: 120),
                Requirement(stars: 1, error: 0, time: 0),
                Requirement(stars: 2, error: 0, time: 0),
                Requirement(stars: 3, error: 0, time: 0)
            ]
        }
    }
}
