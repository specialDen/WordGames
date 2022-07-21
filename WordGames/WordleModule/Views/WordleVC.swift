//
//  WordleVC.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//


import UIKit

protocol WordleVCViewInput: AnyObject {
    var keyboardVC: KeyboardVC?{get set}
    var wordDisplayVC: WordDisplayVC?{get set}
}

class WordleVC: UIViewController {
    
     var keyboardVC:    KeyboardVC?
     var wordDisplayVC: WordDisplayVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        title = "Wordle"
    }
    
    private func addChildren() {
        guard let keyboardVC = keyboardVC else {
            return
        }
        guard let wordDisplayVC = wordDisplayVC else {
            return
        }
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
//        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(wordDisplayVC)
        wordDisplayVC.didMove(toParent: self)
        wordDisplayVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordDisplayVC.view)
        
        addConstraints(keyBoardVC: keyboardVC, wordDisplayVC: wordDisplayVC)
    }
    
    func addConstraints(keyBoardVC: KeyboardVC, wordDisplayVC: WordDisplayVC) {
        
        NSLayoutConstraint.activate([
            wordDisplayVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wordDisplayVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wordDisplayVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wordDisplayVC.view.bottomAnchor.constraint(equalTo: keyBoardVC.view.topAnchor),
            wordDisplayVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyBoardVC.view.topAnchor.constraint(equalTo: wordDisplayVC.view.bottomAnchor),
            keyBoardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyBoardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyBoardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    
}
extension WordleVC: WordleVCViewInput {

    
    
}

