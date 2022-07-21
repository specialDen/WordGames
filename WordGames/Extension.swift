//
//  Extension.swift
//  WordGames
//
//  Created by Izuchukwu Dennis on 09.07.2022.
//

import UIKit

extension UICollectionViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
extension UITableViewCell{
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}

public extension Array where Element == UIView {
    func toStackView(orientation: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: self)
        stackView.axis = orientation
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
}
