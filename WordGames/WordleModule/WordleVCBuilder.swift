//
//  WordleVCBuilder.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import Foundation
import UIKit
struct WordleVCBuilder {
    
    static func createWorldleVC(coordinator: Coordinator) -> UIViewController {
        let wordleVC = WordleVC()
        let wordlePresenter = WordlePresenter()
        let keyboardVC = KeyboardVC()
        let wordDisplayVC = WordDisplayVC()
        
        wordleVC.keyboardVC = keyboardVC
        wordleVC.wordDisplayVC = wordDisplayVC
        wordlePresenter.coordinator = coordinator
        wordlePresenter.view =  wordleVC
        wordleVC.keyboardVC?.delegate = wordlePresenter
        wordleVC.wordDisplayVC?.datasource = wordlePresenter

        
        return wordleVC
    }
//    static func createThirdVC(appModel: AppModel, coordinator: Coordinator) -> ChequeViewController {
//        let thirdVC = ChequeViewController()
//        let viewModel = ChequeVCViewModel(with: appModel)
//        let tableViewManager = TableViewManager()
//        
//        thirdVC.viewModel = viewModel
//        viewModel.coordinator = coordinator
//        viewModel.tableViewManager = tableViewManager
//        viewModel.view = thirdVC
//        
//        tableViewManager.delegate = viewModel
//        
//        return thirdVC
//    }
//    keyboardVC.delegate = self
//    wordDisplayVC.datasource = self
//    answer = answers.randomElement() ?? "Array"
}

