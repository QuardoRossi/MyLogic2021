//
//  Operation.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

enum Operation: String, Codable {
    case add = "s_add" //+
    case subtract = "s_subtract" //-
    case multiply = "s_multiply" //x
    case divide = "s_divide" //÷
}

enum SetCount: String, Codable {
    case one = "+, -"
    case two = "x, ÷"
    case three = "+, -, x"
    case four = "+, -, x, ÷"
}

extension Operation {
    static func getSet(set: SetCount) -> [Operation] {
        switch set {
        case .two: return [
            Operation.multiply,
            Operation.divide
            ]
        case .three: return [
            Operation.add,
            Operation.subtract,
            Operation.multiply
            ]
        case .four: return [
            Operation.add,
            Operation.subtract,
            Operation.multiply,
            Operation.divide
            ]
        default: return [ //.one
            Operation.add,
            Operation.subtract
            ]
        }
    }
}
