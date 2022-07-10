//
//  WordDisplayVC.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//

import UIKit

protocol WordDisplayVCDatasource: AnyObject {
    var currentGuesses: [[String?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class WordDisplayVC: UIViewController {

    weak var datasource: WordDisplayVCDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.backgroundColor = .clear
        collectionVIew.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.reuseIdentifier)
        return collectionVIew
    }()
    
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension WordDisplayVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = datasource?.currentGuesses ?? []
        return guesses[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.reuseIdentifier, for: indexPath) as? KeyCollectionViewCell else {
            fatalError()
        }

        cell.backgroundColor = datasource?.boxColor(at: indexPath)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor

        let guesses = datasource?.currentGuesses ?? []
        if let letter = guesses[indexPath.section][indexPath.row] {
            cell.configure(with: letter)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/5

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 2,
            left: 2,
            bottom: 2,
            right: 2
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
