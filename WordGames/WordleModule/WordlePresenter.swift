//
//  WordlePresenter.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import UIKit


class WordlePresenter: Coordinating {
    
    var coordinator: Coordinator?
    weak var view: WordleVCViewInput?
    
    init() {
        answer = answers.randomElement() ?? "Array"
    }
    
    let answers = [
        "white","later", "bloke", "there", "ultra","third",
    ]
    var currentWord = 0
    var wordChecked = false
    
    
    var answer = ""
    private var guesses: [[LetterStruct?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )
    
    
}


extension WordlePresenter: KeyboardVCDelegate {
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
        var noOfCorrectLetters = 0
        for index in 0..<myGuess[currentWord].count {
            let colour = getColor(at: index, guesses)
            myGuess[currentWord][index]?.color = colour
            if colour == .systemGreen {
                noOfCorrectLetters += 1
            }
        }
        guesses = myGuess
        if noOfCorrectLetters == 5{
            coordinator?.eventOccured(with: .wordle(.success(score: currentWord)))
        }else if (currentWord >= 5){
            coordinator?.eventOccured(with: .wordle(.fail))
        }    
    }
    
    
    func keyboardViewController(_ vc: KeyboardVC, didTapKey letter: String) {
        switch letter {
            
        case "ok":
            if (guesses[currentWord].last! != nil) && (currentWord <= guesses.count - 1){
                
                checkWord()
                if (currentWord < guesses.count - 1){
                    currentWord += 1
                }
                wordChecked = true
            }
        case "del":
            deleteLastLetter()
        default:
            addLetter(letter)
        }
        view?.wordDisplayVC?.reloadData()
    }
}


extension WordlePresenter: WordDisplayVCDatasource {
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

