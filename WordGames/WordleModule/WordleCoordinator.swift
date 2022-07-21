//
//  WordleCoordinator.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import UIKit

class WordleCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Modules) {
        switch type {
            
        case .wordle(let event):
            switch event {
            case .success:
                let scoreboardVc = ScoreBoardVC(with: event)
                self.navigationController?.pushViewController(scoreboardVc, animated: true)
            case .fail:
                let scoreboardVc = ScoreBoardVC(with: event)
                self.navigationController?.pushViewController(scoreboardVc, animated: true)
            case .selectedModule:
                let scoreboardVc = ScoreBoardVC(with: event)
                self.navigationController?.pushViewController(scoreboardVc, animated: true)
            }
        case .anagramSolver:
            return
        }
    }
    
    
    func start()  {
        let vc = WordleVCBuilder.createWorldleVC(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    
}


