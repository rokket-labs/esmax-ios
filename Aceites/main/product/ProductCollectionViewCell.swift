//
//  ProductCollectionViewCell.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/1/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var product = [ProductItem]()
    
    let productImage: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 20).bold()
        label.textColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0) // UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let productDescription: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    func configCell(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0, height: 3.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        backgroundColor = UIColor(red: 0.914, green: 0.953, blue: 0.941, alpha: 1.0)

    }
    
    func setupConstrains(){
        addSubview(productImage)
        addSubview(productName)
        addSubview(productDescription)
        
        let productImageConstrains = [
            productImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            productImage.heightAnchor.constraint(equalToConstant: 150),
            productImage.widthAnchor.constraint(equalToConstant: 85),
            ]
        NSLayoutConstraint.activate(productImageConstrains)
        
        let productNameConstrains = [
            productName.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10.0),
            productName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0),
            productName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25.0),
            ]
        NSLayoutConstraint.activate(productNameConstrains)
        
        let productDescriptionConstrains = [
            productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5.0),
            productDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24.0),
            productDescription.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10.0),
            ]
        NSLayoutConstraint.activate(productDescriptionConstrains)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
