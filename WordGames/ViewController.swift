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
    var currentWord = 0
    var wordChecked = false

        var answer = ""
        private var guesses: [[LetterStruct?]] = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 6
        )
    
    let keyboardVC = KeyboardVC()
    let wordDisplayVC = WordDisplayVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addChildren()
//        keyboardVC.delegate = self
//        wordDisplayVC.datasource = self
//        answer = answers.randomElement() ?? "Array"
//        title = "Wordle"
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
    private func deleteLastLetter(){
        for characterIndex in 0..<guesses[currentWord].count {
            if (guesses[currentWord][characterIndex] == nil) && (characterIndex != 0){
                guesses[currentWord][characterIndex - 1] = nil
                break
            }
        }
    }
    
    private func addLetter(_ letter: String){
        for characterIndex in 0..<guesses[currentWord].count {
            if (guesses[currentWord][characterIndex] == nil) && (characterIndex <= guesses[currentWord].count){
                guesses[currentWord][characterIndex] = LetterStruct(letter: letter)
                break
            }
        }
    }
    private func checkWord() {
        var myGuess = guesses
        for index in 0..<myGuess[currentWord].count {
            myGuess[currentWord][index]?.color = getColor(at: index, guesses)
        }
        
        guesses = myGuess
    }

    
    func keyboardViewController(_ vc: KeyboardVC, didTapKey letter: String) {
        switch letter {
            
        case "ok":
            if (guesses[currentWord].last! != nil) && (currentWord < guesses.count - 1){
                
                checkWord()
                currentWord += 1
                wordChecked = true
            }
        case "del":
            deleteLastLetter()
        default:
            addLetter(letter)
        }
        wordDisplayVC.reloadData()
    }
}


extension ViewController: WordDisplayVCDatasource {
    var currentGuesses: [[LetterStruct?]] {
        return guesses
    }
    
    private func getColor(at index: Int, _ myGuess : [[LetterStruct?]]) -> UIColor?{

            let indexedAnswer = Array(answer)
            guard let letter = myGuess[currentWord][index]?.letter,
                  answer.contains(letter) else {
                        return nil
                    }
            if indexedAnswer[index] == Character(letter) {
                return .systemGreen
            }
        return .systemOrange
    }
    
            
}

enum ColourScheme  {
    case match
    case contains
    case noMatch
}
