//
//  DetailProductTableController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/28/18.
//  Copyright © 2018 Esmax. All rights reserved.
//
import Foundation
import UIKit
import Lottie

struct productDictionary {
    let product: ProductObject?
    let index: String?
}

class DetailProductTableController: UITableViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let cellId = "cellId"
    
    var categoryID =  String()
    var manufactureID = String()
    var modelID = String()
    var typeID = String()
    
    // Sectionize
    var wordSection = [String]()
    var wordDict = [String: [String]]()
    var vehicleDictionary = [String: [ProductObject]]()
    var wordDictObject = [ProductObject]()
    var productList = [ProductObject]()
    let animationView = LOTAnimationView(name: "loading")
    
    func generateWordDict(){

        for word in productList {
            
            let brand: String = (word.engine?.name!)!
            print("brand: \(brand)")
            let key = "\(brand)"

            print("key: \(key)")
            let lower =  key.capitalized //key.lowercased()
            print("lower: \(lower)")
            
            if var wordVal = vehicleDictionary[lower]{
                wordVal.append(word)
                vehicleDictionary[lower] = wordVal
            } else {
                vehicleDictionary[lower] = [word]
            }
        }
        wordSection = [String](vehicleDictionary.keys)
        wordSection = wordSection.sorted()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func fetchData(){
        
        let dataVersion = readPlist(namePlist: "app", key: "unique_key")
        let jsonUrlDomain = "http://api.testcare.me/webservice/product/filter/?category=\(categoryID)&manufacture=\(manufactureID)&model=\(modelID)&type=\(typeID)&unique_key=\(dataVersion)"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: jsonUrlDomain, retry: self.fetchData) { (response: ProductResponse) in
            self.productList = response.product ?? []
            self.generateWordDict()
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.estimatedRowHeight = 180
        self.title = "Productos"
        self.fetchData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return wordSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordSection[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice.current.orientation.isLandscape {
            return 190
        } else {
            print("Portrait")
            return UITableView.automaticDimension

        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        let wordKey = wordSection[section]
        
        if let wordValues = vehicleDictionary[wordKey] {
            return wordValues.count
        }
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let workdKey = wordSection[indexPath.section]
        let product = vehicleDictionary[workdKey]![indexPath.row]
        
        let vc = ViewProductTableViewController()
        vc.product = product
        vc.is_datasheet = true
        navigationController?.pushViewController(vc, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        
        let workdKey = wordSection[indexPath.section]
        let product = vehicleDictionary[workdKey]![indexPath.row]
    
        let url = URL(string: product.image ?? "")
        let myImage = UIImage.init(url: url)
        if(myImage != nil){
            cell.productImage.image = UIImage.init(url: url)
        } else {
            cell.productImage.image = UIImage(named: "default")
        }
        
        cell.productName.text = product.name
        cell.productDescription.text = product.description
        // cell.useGuideArray = product.uses
        cell.accessoryType = .disclosureIndicator

        return cell
    }

}

class ProductCell: UITableViewCell {
    
//    var useGuideArray = [String]() {
//        didSet {
//            // Shows the content of `useGuideArray`
//            print(useGuideArray)
//
//            // Cleaning the stackView
//            useGuideStack.subviews.forEach({ $0.removeFromSuperview() })
//
//            // Adding the views
//            useGuideStack.addArrangedSubview(stackTitleLabel)
//
//            for row in useGuideArray {
//                let viewImage = UIImageView()
//                viewImage.image = UIImage(named: row)
//                viewImage.contentMode = .scaleAspectFit
//                useGuideStack.addArrangedSubview(viewImage)
//            }
//        }
//    }
    
    
//    var formatArray = [String]() {
//        didSet {
//            // Shows the content of `useGuideArray`
//            print(useGuideArray)
//            
//            // Cleaning the stackView
//            useGuideStack.subviews.forEach({ $0.removeFromSuperview() })
//            
//            // Adding the views
//            useGuideStack.addArrangedSubview(stackTitleLabel)
//            
//            for row in useGuideArray {
//                let viewImage = UIImageView()
//                viewImage.image = UIImage(named: row)
//                useGuideStack.addArrangedSubview(viewImage)
//            }
//        }
//    }
    
    
    
    let productImage: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
//        label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20).bold()
        label.textColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        label.backgroundColor = UIColor.blue
        return label
    }()
    
    let productDescription: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        label.backgroundColor = UIColor.red
        return label
    }()
    
//    let useGuideStack: UIStackView = {
//       let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
////        stack.backgroundColor = UIColor.green
//        stack.alignment = .fill
//        stack.distribution = .fillProportionally
//        return stack
//    }()
    

    let stackTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14).bold()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Guida de uso"
        return label
    }()
    

    
    func setupLayout(){
//        useGuideArray.append("auto")
//        useGuideArray.append("industrial")
//        useGuideArray.append("truck")
//        print(useGuideArray)
        
        addSubview(productImage)
        addSubview(productName)
        addSubview(productDescription)
        //addSubview(useGuideStack)
        
//        useGuideStack.addArrangedSubview(stackTitleLabel)
//
//        for row in useGuideArray {
//            let viewImage = UIImageView()
//            viewImage.image = UIImage(named: row)
//            viewImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//            viewImage.contentMode = .scaleAspectFit
//            useGuideStack.addArrangedSubview(viewImage)
//        }
        
        
        
        
        
    
        let productImageConstrains = [
            productImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            productImage.heightAnchor.constraint(equalToConstant: 140),
            productImage.widthAnchor.constraint(equalToConstant: 85),
        ]
        
        NSLayoutConstraint.activate(productImageConstrains)
        
        let productNameConstrains = [
            productName.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10.0),
            productName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            productName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25.0),
            productName.heightAnchor.constraint(equalToConstant: 25),
        ]
        
        NSLayoutConstraint.activate(productNameConstrains)
        
        let productDescriptionConstrains = [
            productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5.0),
            productDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24.0),
            productDescription.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10.0),
            productDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:-20.0)
        ]
        
        NSLayoutConstraint.activate(productDescriptionConstrains)
    
        
//        let useGuideStackConstrains = [
////            useGuideStack.topAnchor.constraint(equalTo: productDescription.bottomAnchor, constant: 5.0),
//            useGuideStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24.0),
//            useGuideStack.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10.0),
//            useGuideStack.heightAnchor.constraint(equalToConstant: 45),
//            useGuideStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
//        ]
//
//        NSLayoutConstraint.activate(useGuideStackConstrains)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

