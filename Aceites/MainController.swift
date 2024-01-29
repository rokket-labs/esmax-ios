//
//  HomeCollectionViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/19/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit


class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionview: UICollectionView!
//    var productCollectionView: UICollectionView!
    
    var label = UILabel()
    var container = UIView()
    var cellId = "Cell"
//    var productCellId = "Cell2"
    
    let menuOptions = [AppMenu(id:"1", name:"Buscar Lubricantes", imageUrl:"search"),
                       AppMenu(id:"2", name:"Fichas Técnicas", imageUrl:"datasheet"),
                       AppMenu(id:"3", name:"Tabla Equivalencias", imageUrl:"table"),
                       AppMenu(id:"4", name:"Preguntas Frecuentes", imageUrl:"faq")]
    
    
    fileprivate func setupTitle(){
        
        let logo = UIImage(named: "lubrax_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    fileprivate func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.96, alpha:1.0)
        
        self.view.addSubview(collectionview)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTitle()
        self.setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(menuOptions.count)
        return menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = CGFloat()
        cellWidth = CGFloat((self.view.frame.size.width / 2) - 30)
        
        var cellHeight = CGFloat()
        cellHeight = cellWidth * 180 / 180
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let menu = menuOptions[indexPath.row]
        
        cell.nameLabel.text = menu.name
        cell.imageView.image = UIImage(named: menu.imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = menuOptions[indexPath.row]
        print(menu.name)
        
        if(menu.id == "1"){
            let searchCarViewController = VehicleCategoryTableController()
            navigationController?.pushViewController(searchCarViewController, animated: true)
        }
        else if (menu.id == "3"){
            let MotorController = MotorTypeController()
            navigationController?.pushViewController(MotorController, animated: true)
        }
        else if (menu.id == "4"){
            let ListFaqsViewController = ListFaqTableController()
            navigationController?.pushViewController(ListFaqsViewController, animated: true)
        }
        else if (menu.id == "5"){
            let EditViewController = EditUrlController()
            navigationController?.pushViewController(EditViewController, animated: true)
        }
    }
}

class MenuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let label = UIImageView()
        label.frame = CGRect(x: 30, y: 10, width: 100, height: 100)
        label.contentMode = .scaleToFill
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    // Define attributes
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16).bold()
        label.textColor = UIColor(red:0.47, green:0.59, blue:0.66, alpha:1.0)
        label.numberOfLines = 3
        

        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 105, width: 140, height: 50)
        label.textAlignment = .center
//        label.backgroundColor = UIColor.blue
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor(red: 0.345, green: 0.675, blue: 0.529, alpha: 1.0).cgColor : UIColor.clear.cgColor
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
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
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageView.center.x = self.contentView.center.x
        imageView.center.y = self.contentView.center.y-30
        
        nameLabel.center.x = self.contentView.center.x
        nameLabel.center.y = self.contentView.center.y+40
    
        
    }
    
    
    
}
