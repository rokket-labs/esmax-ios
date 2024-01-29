//
//  EquivalenceTableView.swift
//  Aceites
//
//  Created by Eddwin Paz on 1/14/19.
//  Copyright © 2019 Esmax. All rights reserved.
//

import UIKit

class EquivalenceTableView: UITableViewController {
    
    var product: ProductObject?
    var products = [EquivalentArray]()
    var productSections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tabla Equivalencia"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(HeadCustomTableCell.self, forCellReuseIdentifier: "HeadCustomTableCell")
        
        
        productSections.append("")
        productSections.append("Tabla Equivalencia")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return productSections.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return products.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return productSections[section]
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
            
            cell.productName.text = product?.name
            cell.productTitle.text = product?.engine?.name ?? "N/A"
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
            
            // Configure the cell...
            cell.textLabel?.text = products[indexPath.row].name
            if(products[indexPath.row].product?.count != 0){
                cell.detailTextLabel?.text = products[indexPath.row].product
            } else {
                cell.detailTextLabel?.text = "No disponible"
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

