//
//  MotorTypeController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/28/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class MotorTypeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionview: UICollectionView!
    var label = UILabel()
    var container = UIView()
    var cellId = "Cell"
    
    let carList = [
        MotorType(id:"1", name:"Shell", imageUrl:"shell_ios"),
        MotorType(id:"2", name:"Total", imageUrl:"total_ios"),
        MotorType(id:"3", name:"Mobil", imageUrl:"mobil_ios"),
        MotorType(id:"4", name:"Bp", imageUrl:"bp_ios"),
        MotorType(id:"5", name:"Texaco", imageUrl:"texaco_ios"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Competidores"
        
        let screenSize = UIScreen.main.bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: screenSize.width/2, height: screenSize.width/2)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        //        collectionview!.collectionViewLayout = layout
        
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MotorTypeCell.self.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.96, alpha:1.0)
        self.view.addSubview(collectionview)
        
        collectionview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.bounds.size.width
        let cal_width = ((width / 2) - 20)
        return CGSize(width: cal_width , height: 170)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MotorTypeCell
        let menu = carList[indexPath.row]
        
        cell.nameLabel.text = menu.name
        cell.imageView.image = UIImage(named: menu.imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let car = carList[indexPath.row]
        
        print(car.id)
        print(car.name)
        
        // Send Selected Car ID to next View Controller
        let VC = ProductTableController()
        VC.company_id = car.id
        print(car.id)
        navigationController?.pushViewController(VC, animated: true)
        
    }
}

class MotorTypeCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let label = UIImageView()
//        label.frame = CGRect(x: 30, y: 10, width: 100, height: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        return label
    }()
    
    // Define attributes
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 19).bold()
        label.textColor = UIColor(red:0.47, green:0.59, blue:0.66, alpha:1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.frame = CGRect(x: 10, y: 105, width: 140, height: 50)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor(red: 0.345, green: 0.675, blue: 0.529, alpha: 1.0).cgColor : UIColor.clear.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        
        layer.cornerRadius = 16.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor = UIColor.white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 16.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        addSubview(imageView)
        addSubview(nameLabel)
//        imageView.backgroundColor = UIColor.red
//        nameLabel.backgroundColor = UIColor.blue
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    
}
