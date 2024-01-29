//
//  MenuTableViewCell.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/1/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit


class MenuTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var timerTest : Timer?
    weak var myParent:UITableViewController?
    
    let menuOptions = [AppMenu(id:"1", name:"Buscar Lubricantes", imageUrl:"search"),
                       AppMenu(id:"2", name:"Fichas Técnicas", imageUrl:"datasheet"),
                       AppMenu(id:"3", name:"Tabla Equivalencias", imageUrl:"table"),
                       AppMenu(id:"4", name:"Preguntas Frecuentes", imageUrl:"faq")]
    
    var myCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout) // .zero
        view.backgroundColor = UIColor(red: 0.953, green: 0.957, blue: 0.965, alpha: 1.0)
        view.clipsToBounds = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
        
//        view.backgroundColor = UIColor.yellow
        
        return view
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "¿Que deseas hacer?"
        label.font = UIFont.systemFont(ofSize: 24).bold()
        label.textColor = UIColor(red: 0.498, green: 0.608, blue: 0.675, alpha: 1.0)
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
//        label.backgroundColor = UIColor.red
        
        return label
    }()
    
    
    func setupViews(){
        
        self.contentView.addSubview(titleLabel)
        
        let titleLabelConstraint = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraint)
        
        // CollectionView Visual Settigns (Constrains)
        contentView.addSubview(myCollectionView)

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.red

        let myCollectionViewConstraint = [
            myCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            myCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            myCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            myCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(myCollectionViewConstraint)
        
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellId", for: indexPath) as! MenuCollectionViewCell
        
        let menu = menuOptions[indexPath.row]
        cell.nameLabel.text = menu.name
        cell.imageView.image = UIImage(named: menu.imageUrl)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 157.0, height: 157.0)
//        var cellWidth = CGFloat()
//        cellWidth = (CGFloat((collectionView.frame.size.width / 2) - 30) > 157.5) ? 157.5 : CGFloat((collectionView.frame.size.width / 2) - 30)
//
//        var cellHeight = CGFloat()
//        cellHeight = (cellWidth * 180 / 180) > 157.5 ? 157.5 :  (cellWidth * 180 / 180)
//
//        return CGSize(width: cellWidth, height: cellHeight)
        
        let cellWidth = (contentView.bounds.size.width-50) / 2
        let cellHeight = cellWidth * 0.9 // multiply by some factor to make cell rectangular not square

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let menu = menuOptions[indexPath.row]

        let searchCarViewController = VehicleCategoryTableController()
        myParent?.navigationController?.pushViewController(searchCarViewController, animated: true)
    }
}
