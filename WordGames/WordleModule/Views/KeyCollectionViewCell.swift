//
//  KeyCollectionViewCell.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//

import UIKit

class KeyCollectionViewCell:UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray2
        contentView.addSubview(label)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(labelConstraints)
        label.frame = contentView.bounds
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with letter: String) {
            label.text = letter.uppercased()
        }
}
