//
//  MenuCollectionViewCell.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/1/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit


class MenuCollectionViewCell: UICollectionViewCell {
    
    
    var menu =  [AppMenu]()
    
    let imageView: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16).bold()
        label.textColor = UIColor(red:0.47, green:0.59, blue:0.66, alpha:1.0)
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor(red: 0.345, green: 0.675, blue: 0.529, alpha: 1.0).cgColor : UIColor.clear.cgColor
        }
    }
    
    func setupViews(){
        
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor = UIColor.white
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        layer.shadowRadius = 10.0
//        layer.shadowOpacity = 0.1
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        let imageViewConstrains = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
        ]
        NSLayoutConstraint.activate(imageViewConstrains)
        
        let nameLabelConstrains = [
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10.0),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0)
        ]
        NSLayoutConstraint.activate(nameLabelConstrains)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
