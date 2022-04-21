//
//  GDView.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 22/04/22.
//

import UIKit

extension UIView {
    func setUpConstraint(superView: UIView) {
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        superView.addConstraints([top, bottom, left, right])
    }
}
