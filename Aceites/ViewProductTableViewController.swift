//
//  ViewProductTableViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/3/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit


class ViewProductTableViewController: UITableViewController {
    
    var product: ProductObject?
    var is_datasheet: Bool!
    var productSections = [String]()

    var productDescription = String()
    var productFormats = [String]()
    var productUse = [String]()
    var productFile = String()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
    
    @objc func goRootVc(sender: UIBarButtonItem){
        self.navigationController?.popToRootViewController(animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (is_datasheet){
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Volver", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goRootVc(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
        
        

        self.title = product?.name
        productDescription = product?.description ?? ""
        productFile = product?.pdf ?? ""
        
        var formatObject = [DetailArray]()
        formatObject = (product?.formats)!
        
        for format in formatObject {
            print("Format ID: \(String(describing: format.id)), Name. \(String(describing: format.name))")
            let formatID:String = String(describing: format.id ?? 00)
            productFormats.append("format"+formatID)
        }
        
        print(productFormats)
        
        
        var useObject = [DetailArray]()
        useObject = (product?.uses)!
        
        for use in useObject {
            print("Format ID: \(String(describing: use.id)), Name. \(String(describing: use.name))")
            let useID:String = String(describing: use.id ?? 00)
            productUse.append("use"+useID)
        }
        
        print(productUse)
        
        
        // Fake product information
        productSections.append("")
        productSections.append("Descripción")
        productSections.append("Tipo de Formatos")
        productSections.append("Tipo de Usos")
        productSections.append("Ficha Técnica")
//        productSections.append("Tabla Equivalencias")
        
        
        productFile = "Descargar"
        // productUse = ["auto", "moto", "largetruck", "auto", "moto", "largetruck"]
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(HeadCustomTableCell.self, forCellReuseIdentifier: "HeadCustomTableCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(CustomTypesTableViewCell.self, forCellReuseIdentifier: "CustomTypesTableViewCell")
        
        // Save Object to Plist
        var products = [ProductObject]()
        let favoritos = getFavorites()
        
        if (favoritos != nil) {
            if (favoritos?.count)! > 0 {
                for p in favoritos! {
                    print("appending old products")
                    products.append(p)
                }
            }
            if(favoritos?.count == 6) {
                products.removeFirst()
            }
        }
        
        print("append new product")
        
        if products.contains(where: { $0.name == product?.name }) {
            // found
            print("product exists, so it wont be append it")
        } else {
            // not
            products.append(product!)

        }
        
        
        // Save JSON Response to Plist file
        let placesData = try! JSONEncoder().encode(products)
        UserDefaults.standard.set(placesData, forKey: "favorites")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return productSections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return productSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadCustomTableCell", for: indexPath) as! HeadCustomTableCell
            
            let url = URL(string: product?.image ?? "")
            let myImage = UIImage.init(url: url)
            if(myImage != nil){
                cell.productImage.image = UIImage.init(url: url)
            } else {
                cell.productImage.image = UIImage(named: "default")
            }
            
//            cell.productImage.image = UIImage(named: "default")
            cell.productName.text = product?.name
            cell.productTitle.text =  String(describing: product?.engine?.name ?? "N/A")
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = product?.description
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.textLabel?.textColor = UIColor(red: 0.498, green: 0.608, blue: 0.675, alpha: 1.0)
            cell.selectionStyle = .none
//            cell.textLabel?.textColor = UIColor(red: 0.498, green: 0.608, blue: 0.675, alpha: 1.0)
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTypesTableViewCell", for: indexPath) as! CustomTypesTableViewCell
            cell.useGuideArray = productFormats
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTypesTableViewCell", for: indexPath) as! CustomTypesTableViewCell
            cell.useGuideArray = productUse
            cell.selectionStyle = .none
            return cell
            
        }
        else if indexPath.section == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = productFile
            cell.textLabel?.textColor = UIColor(red: 0.498, green: 0.608, blue: 0.675, alpha: 1.0)
            cell.selectionStyle = .none
            return cell
        }
        
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            print("Segue")
            let vc = FileViewController()
            vc.file_url = product?.pdf
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

class HeadCustomTableCell: UITableViewCell {
    
    var productImage: UIImageView = {
        let imageObject = UIImageView()
        imageObject.contentMode = .scaleAspectFit
        imageObject.translatesAutoresizingMaskIntoConstraints = false
        return imageObject
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.text = "LUBRAX SUPER POWER HD"
        label.font = UIFont.systemFont(ofSize: 20).bold()
        label.textColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0) //UIColor.darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productTitle: UILabel = {
        let label = UILabel()
        label.text = "Para motores Diesel"
        label.font = UIFont.systemFont(ofSize: 17).bold()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageUrl: UILabel = {
        let label = UILabel()
        label.text = "00"
        return label
    }()
    
    func setupViews(){
        
        // Product Image Constrains
        addSubview(productImage)

        let productImageconstrains = [
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImage.widthAnchor.constraint(equalToConstant: 150),
            productImage.heightAnchor.constraint(equalToConstant: 150)
        ]

        NSLayoutConstraint.activate(productImageconstrains)
        
        // Product Name Constrains
        addSubview(productName)
        
        let productNameconstrains = [
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            productName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            productName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(productNameconstrains)
        
        // Product Title Constrains
        addSubview(productTitle)
        
        let productTitleconstrains = [
            productTitle.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10),
            productTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

            productTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            productTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(productTitleconstrains)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CustomTypesTableViewCell: UITableViewCell {
    
    var useGuideArray = [String]() {
        didSet {
            // Shows the content of `useGuideArray`
            // print(useGuideArray)
            
            // Cleaning the stackView
            useGuideStack.subviews.forEach({ $0.removeFromSuperview() })
            
            // Adding the views
            //useGuideStack.addArrangedSubview(stackTitleLabel)
            
            for row in useGuideArray {
                
                let viewImage = UIImageView()
                viewImage.image = UIImage(named: row)
                viewImage.contentMode = .scaleAspectFit
                viewImage.translatesAutoresizingMaskIntoConstraints = false
                viewImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
                viewImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
                
                useGuideStack.addArrangedSubview(viewImage)
            }
        }
    }
    
    var useGuideStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    func setupViews(){
        
        addSubview(useGuideStack)
        
        let useGuideStackConstrains = [
            useGuideStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            useGuideStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            useGuideStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
        ]
        NSLayoutConstraint.activate(useGuideStackConstrains)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


