//
//  Model.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//
import UIKit

struct Keys {
    
    static let firstRow: [String] = ["q","w","e","r", "t", "y", "u", "i", "o", "p"]
    static let secondRow:  [String] = ["a","s","d","f","g","h","j","k","l"]
    static let lastRow: [String] = ["del","z","x", "c", "v", "b", "n", "m", "ok"]
}

struct KeysManager {
    
//    let keys: [[String]] = [Keys.firstRow, Keys.secondRow, Keys.lastRow]
    let sections: [Sections] = [.first(Keys.firstRow), .second(Keys.secondRow), .third(Keys.lastRow)]
}

struct LetterStruct {
    var letter: String
    var color: UIColor?
}


enum Sections {
    case first(_ model: [String])
    case second(_ model: [String])
    case third(_ model: [String])
}
