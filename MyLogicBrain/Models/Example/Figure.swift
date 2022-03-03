//
//  Figure.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 28.01.2021.
//

struct Figure: Codable {
    let symbol: String
}

extension Figure {
    static func getSet() -> [Figure] {
        return [
            Figure(symbol: "f_orange"),
            Figure(symbol: "f_blue"),
            Figure(symbol: "f_green"),
            Figure(symbol: "f_yellow")
        ]
    }
    
    static func getSet(set: SetCount) -> [Figure] {
        switch set {
        case .two:
            var figures = Figure.getSet()
            figures.shuffle()
            figures.removeFirst()
            figures.removeLast()
            return figures
        case .three:
            var figures = Figure.getSet()
            figures.shuffle()
            figures.removeLast()
            return figures
        case .four:
            var figures = Figure.getSet()
            figures.shuffle()
            return figures
        default:
            var figures = Figure.getSet()
            figures.shuffle()
            return figures
        }
    }
}
