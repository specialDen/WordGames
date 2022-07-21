//
//  ScoreBoardVC.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import UIKit

class ScoreBoardVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        switch value{
            
        case .success(score: let score):
            titleLabel.text = "Congratulations"
//            self.score = score
            stackView.backgroundColor = .green
            
            noOfMovesLabel.text = "no of moves \(String(describing: score!) )"
        case .fail:
            titleLabel.text = "Failed"
            stackView.backgroundColor = .red
            noOfMovesLabel.text = "Please try again"
        case .selectedModule:
            break
        }
        view.addSubview(stackView)
//        stackView.center = view.center
        setConstraints()
    }
    var value: WordleEvents
//    var score: Int?
    
    
    init(with value: WordleEvents) {
        self.value = value
        super.init(nibName: .none, bundle: .none)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: "Snell Roundhand", size: 32)
        label.textAlignment = .right
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let BestOfLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let noOfMovesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        [titleLabel, noOfMovesLabel].toStackView(orientation: .vertical, distribution: .fill, spacing: 5.0)
    }()
    
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewConstraints = [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                                    stackView.widthAnchor.constraint(equalToConstant: view.bounds.size.width/1.5),
//                                    stackView.heightAnchor.constraint(equalToConstant: view.bounds.size.height/2)
                                    ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
}
