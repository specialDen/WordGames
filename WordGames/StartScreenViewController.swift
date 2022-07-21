//
//  StartScreenViewController.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 13.07.2022.
//

import UIKit

class StartScreenViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    private func setUpUI(){
        view.addSubview(stackView)
        view.addSubview(label)
        setConstraints()
    }
    
    private lazy var stackView: UIStackView = {
        [wordleButton, anagramSolverButton].toStackView(orientation: .vertical, distribution: .fillEqually, spacing: 5.0)
    }()
    
    private func setConstraints(){
        let viewHeight = view.frame.size.height
        let viewWidth = view.frame.size.width
        stackView.frame = CGRect(x: viewWidth/4, y: viewHeight/1.5, width: viewWidth/2, height: viewHeight/6)
        
        let labelConstraints = [ label.topAnchor.constraint(equalTo: view.topAnchor),
                                 label.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 1.5 * viewHeight/3),
                                 label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints )
    }
    
    @objc private func didTapWordle() {
        coordinator?.eventOccured(with: .wordle(.success(score: nil)))
    }
    
    private let wordleButton: ReuseButton = {
        let button = ReuseButton(withTitle: Modules.moduleTitle(for: 0))
        button.addTarget(self, action: #selector(didTapWordle), for: .touchUpInside)
        return button
    }()
    
    private let anagramSolverButton: ReuseButton = {
        let button = ReuseButton(withTitle: Modules.moduleTitle(for: 0))
        button.addTarget(self, action: #selector(didTapWordle), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "WordGames"
        label.font = .init(name: "Zapfino", size: 32)
        return label
    }()

}

class ReuseButton: UIButton {
    
    init (withTitle title: String){
        super.init(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .blue
//        self.target(forAction: selector, withSender: sender)
        self.layer.cornerRadius = self.frame.size.height/2
//        self.titleLabel?.font = UIFont(name: "fontName", size: fontSize)
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

