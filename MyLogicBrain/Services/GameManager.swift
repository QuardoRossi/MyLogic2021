//
//  GameManager.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

class GameManager {
    
    static let shared = GameManager()
    
    func getElements(countOperations: SetCount) -> ([Operation], [Figure]) {
        let operations = Operation.getSet(set: countOperations)
        let figures = Figure.getSet(set: countOperations)
        
        return (operations, figures)
    }
    
    func getExample(game: Game, operations: [Operation], figures: [Figure]) -> Example {
        var example = Example.getBase()
        let setCount: Int
        switch game.set {
        case .one:
            setCount = 2
        case .two:
            setCount = 2
        case .three:
            setCount = 3
        case .four:
            setCount = 4
        }
        
        let count = Int.random(in: 0...(setCount-1))
        example.operation = operations[count]
        example.figure = figures[count]
        
        func getRandomLeft() {
            switch game.operands["left"] {
            case 1:
                example.leftNum = Int.random(in: 2...9)
            case 2:
                example.leftNum = Int.random(in: 11...99)
            case 3:
                example.leftNum = Int.random(in: 100...999)
            default:
                break
            }
        }
        
        func getRandomRight() {
            switch game.operands["right"] {
            case 1:
                example.rightNum = Int.random(in: 1...9)
            case 2:
                example.rightNum = Int.random(in: 10...98)
            case 3:
                example.rightNum = Int.random(in: 100...998)
            default:
                break
            }
        }
        
        getRandomLeft()
        getRandomRight()
        
        switch example.operation {
        case .add:
            example.calculate()
        case .subtract:
            switch game.operands["right"] {
            case 1:
                if example.leftNum <= 9 {
                    example.rightNum = Int.random(in: 1..<example.leftNum)
                }
            case 2:
                if example.leftNum <= 99 {
                    example.rightNum = Int.random(in: 10..<example.leftNum)
                }
            case 3:
                if example.leftNum <= 999 {
                    example.rightNum = Int.random(in: 100..<example.leftNum)
                }
            default:
                break
            }
            example.calculate()
        case .multiply:
            example.calculate()
        case .divide:
            switch game.operands["right"] {
            case 1:
                repeat {
                    getRandomLeft()
                    if example.leftNum <= 9 {
                        example.rightNum = Int.random(in: 1..<example.leftNum)
                    } else { getRandomRight() }
                    example.answer = example.leftNum % example.rightNum
                } while example.answer != 0
                example.calculate()
            case 2:
                repeat {
                    getRandomLeft()
                    if example.leftNum <= 99 {
                        example.rightNum = Int.random(in: 10..<example.leftNum)
                    } else { getRandomRight() }
                    example.answer = example.leftNum % example.rightNum
                } while example.answer != 0
                example.calculate()
            default: break
            }
        }
        
        example.answers = getAnswerChoice(with: example.answer)
        
        return example
    }
    
    func getResult(dataGame: Game, dataUser: User, countset: Count) -> ResultGame {
        var message = "is not passed"
        var user = dataUser
        var newStar = false
        var count = countset
        let requirement = Requirement.getRequirement(level: user.level)
        let countsetTime = countset.time

        if user.stars >= 1 {
        message = "is passed"
        }
        
        func updateTimeAndStars(stars: Int) {
            if stars > user.stars {
                user.stars = stars
                newStar = true
                user.bestTime = nil
            }
            
            if stars >= 1 {
                message = "is passed"
                
                if let users = StorageManager.shared.fetchDataUser() {
                var userNew = users[user.level]
                
                userNew.opened = 1 //true
                    
                    StorageManager.shared.updateDataUser(user: userNew)
                }
            }
            
            if user.bestTime != nil {
                let bestTime = user.bestTime!

                let raznica = bestTime - countsetTime
                
                if raznica > 0 {
                user.bestTime = countsetTime
                user.bestError = countset.error
                }
            } else {
                user.bestTime = countsetTime
                user.bestError = countset.error
            }
        }
        // 3 star
        if countset.error == requirement[2].error && countsetTime <= requirement[2].time {
            updateTimeAndStars(stars: 3)
            count.stars = 3
        } else
        // 2 star
        if countset.error <= requirement[1].error && countsetTime <= requirement[1].time {
            updateTimeAndStars(stars: 2)
            count.stars = 2
        } else
        // 1 star
        if countset.error <= requirement[0].error && countsetTime <= requirement[0].time {
            updateTimeAndStars(stars: 1)
            count.stars = 1
        }

        StorageManager.shared.updateDataUser(user: user)

        let resultGame = ResultGame(message: message,
                                    game: dataGame,
                                    user: user,
                                    count: count,
                                    newStar: newStar)
        
        return resultGame
    }
    
    // MARK: - Private Methods
    private func getAnswerChoice(with answerCorrect: Int) -> [Int] {
        let countChar = countingNumberCharacters(with: String(answerCorrect))
        var answerChoice = [answerCorrect]
        let range: ClosedRange<Int>
        var count = 0
        var testRepeat = false
        
        switch countChar {
        case 2:
            range = 10...99
        case 3:
            range = 100...999
        case 4:
            range = 1000...9999
        default: // 1
            range = 1...9
        }
        
        var randomElements = Array(range)
        
        repeat {
            randomElements.shuffle()
            
            for answer in answerChoice {
                if answer == randomElements[0] {
                    testRepeat = true
                }
            }
            
            if testRepeat != true {
                answerChoice.append(randomElements[0])
                count += 1
            } else { testRepeat = false }
            randomElements.remove(at: 0)
        } while count < 3
        
        answerChoice.shuffle()
        return answerChoice
    }
    
    private func countingNumberCharacters(with string: String) -> Int {
        var count = 0
        for _ in string {
            count += 1
        }
        
        return count
    }
    
    
}
//            if user.bestTime == nil || user.bestTime! > countset.time {
//                user.bestTime = countset.time
//                user.bestError = countset.error
//                message = "New best time!"
//            }
