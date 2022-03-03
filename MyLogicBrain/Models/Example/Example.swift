//
//  Example.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

struct Example {
    var operation: Operation
    var figure: Figure
    var leftNum: Int
    var rightNum: Int
    var answer: Int
    var answers: [Int] //4 piece, first is correct
}

extension Example {
    static func getBase() -> Example {
        Example(operation: .add,
                figure: .init(symbol: "🤩"),
                leftNum: 1,
                rightNum: 1,
                answer: 2,
                answers: [1, 2, 3, 4])
    }
    
    mutating func calculate() {
        switch operation {
        case .add: answer = leftNum + rightNum
        case .subtract: answer = leftNum - rightNum
        case .multiply: answer = leftNum * rightNum
        case .divide: answer = leftNum / rightNum
        }
    }
}
