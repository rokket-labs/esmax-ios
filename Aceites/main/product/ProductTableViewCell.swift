//
//  ProductTableViewCell.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/1/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var timerTest : Timer?
    var navControl: UINavigationController?
    var productList = [ProductObject]() {
        didSet {
            for row in productList {
                productList.append(row)
            }
        }
    }
    var myCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:  0, left: 0, bottom: 0, right: 0)
//        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 25
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
        return view
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Búsquedas Recientes"
        label.font = UIFont.systemFont(ofSize: 22).bold()
        label.textColor = UIColor(red: 0.773, green: 0.776, blue: 0.773, alpha: 1.0)
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        label.backgroundColor = UIColor.red
        return label
    }()

    func setupViews(){
        
        self.backgroundColor = UIColor.white
        
        // Title Label Visual Settings (Constrains)
         contentView.addSubview(subTitleLabel)
         contentView.addSubview(myCollectionView)
        
        let subTitleLabelConstraint = [
            subTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            subTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            subTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
        ]
        
        NSLayoutConstraint.activate(subTitleLabelConstraint)
        
        // CollectionView Visual Settigns (Constrains)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        let myCollectionViewConstraint = [
            myCollectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 0.0),
            myCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            myCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            myCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let positionX = scrollView.contentOffset.x
        if(positionX > 0){
            if (positionX >= scrollView.frame.size.width * 4){
                myCollectionView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
            }
        } else if (positionX < 0) {
            myCollectionView.contentOffset = CGPoint(x: scrollView.frame.size.width * 4, y: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellId", for: indexPath) as! ProductCollectionViewCell
        
        let product = productList[indexPath.row]
        
        let url = URL(string: product.image ?? "")
        let myImage = UIImage.init(url: url)
        
        if(myImage != nil){
            cell.productImage.image = UIImage.init(url: url)
        } else {
            cell.productImage.image = UIImage(named: "default")
        }
        
        cell.productName.text = product.name
        
        if((product.description?.count)! > 60){
            cell.productDescription.text =  "\(String(describing: product.description?.subString(from: 0, to: 60) ?? "")) ..."
        } else {
            cell.productDescription.text =  "\(String(describing: product.description ?? "")) ..."
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = productList[indexPath.row]
    
        print("tapped , ",product.name ?? "")
        print("uk , ",product.uniqueKey ?? "")
        
        let modelVc = ViewProductTableViewController()
        modelVc.product = product
        modelVc.is_datasheet = false
        navControl?.pushViewController(modelVc, animated: true)
    }
}
