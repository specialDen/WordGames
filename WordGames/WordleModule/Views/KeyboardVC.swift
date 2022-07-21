//
//  KeyboardVC.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//

import UIKit

protocol KeyboardVCDelegate: AnyObject {
    func keyboardViewController(
        _ vc: KeyboardVC,
        didTapKey letter: String
    )
}

class KeyboardVC: UIViewController {
    
    weak var delegate: KeyboardVCDelegate?

    let keys = KeysManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

}

extension KeyboardVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch keys.sections[section] {
            
        case
                .first(let row),
                .second(let row),
                .third(let row):
            return row.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.reuseIdentifier, for: indexPath) as? KeyCollectionViewCell else {
            fatalError()
        }
        switch keys.sections[indexPath.section] {
        case .first(let row), .second(let row), .third(let row):
            let letter = row[indexPath.row]
            cell.configure(with: letter)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width - margin)/10
        
        switch keys.sections[indexPath.section] {
        case .third(let row) where (indexPath.row == 0 || indexPath.row == row.count - 1):
            return CGSize(width: size * 1.5 , height: size*1.5)
        case .first, .second, .third:
            return CGSize(width: size, height: size*1.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        var left: CGFloat = 1
        var right: CGFloat = 1

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        print(count)

        let inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count))/2
        print(inset)
        
        

        left = inset
        right = inset
        if section == 2 {
            left = 1
            right = 1
        }
        return UIEdgeInsets(
            top: 2,
            left: left,
            bottom: 2,
            right: right
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //
            collectionView.deselectItem(at: indexPath, animated: true)
        switch keys.sections[indexPath.section] {
        case .first(let row), .second(let row), .third(let row):
            let letter = row[indexPath.row]
                delegate?.keyboardViewController(self,
                                                 didTapKey: letter)
        }

        }
    
    
}
