//
//  Coordinator.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import UIKit

enum WordleEvents  {
    case success(score: Int?)
    case fail
    case selectedModule
}
enum Modules: CaseIterable  {
    static var allCases: [Modules] {
        [.wordle(.success(score: nil)), .anagramSolver]
    }
    static func moduleTitle(for index: Int) -> String {
        switch allCases[index] {
            
        case .wordle:
            return "Wordle"
        case .anagramSolver:
            return "Anagram Solver"
        }
    }
    
    case wordle(WordleEvents)
    case anagramSolver
}


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? {get set}
    func eventOccured(with type: Modules)
    func start()
//    var coordinator: [Coordinator?] {get set}
}


protocol Coordinating: AnyObject {
    var coordinator: Coordinator? {get set}
}
