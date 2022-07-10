//
//  ViewController.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let answers = [
            "later", "bloke", "there", "ultra"
        ]

        var answer = ""
        private var guesses: [[String?]] = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 6
        )
    
    let keyboardVC = KeyboardVC()
    let wordDisplayVC = WordDisplayVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        keyboardVC.delegate = self
        wordDisplayVC.datasource = self
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
//        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(wordDisplayVC)
        wordDisplayVC.didMove(toParent: self)
        wordDisplayVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordDisplayVC.view)
        
        addConstraints()
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            wordDisplayVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wordDisplayVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wordDisplayVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wordDisplayVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            wordDisplayVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVC.view.topAnchor.constraint(equalTo: wordDisplayVC.view.bottomAnchor),
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    
}

extension ViewController: KeyboardVCDelegate {
    func keyboardViewController(_ vc: KeyboardVC, didTapKey letter: String) {

        // Update guesses
        var stop = false

        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }

            if stop {
                break
            }
        }

        wordDisplayVC.reloadData()
    }
}

extension ViewController: WordDisplayVCDatasource {
    var currentGuesses: [[String?]] {
        return guesses
    }

    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return nil
        }

        let indexedAnswer = Array(answer)

        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(Character(letter)) else {
            return nil
        }

        if indexedAnswer[indexPath.row] == Character(letter) {
            return .systemGreen
        }


        return .systemOrange
    }
}
