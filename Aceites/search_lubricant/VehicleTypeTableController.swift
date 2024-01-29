//
//  TypeVc.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/26/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit
import Lottie

class VehicleTypeTableController: UITableViewController {
    
    var categoryID =  String()
    var manufactureID = String()
    var modelID = String()
    var typeID = String()
    
    let animationView = LOTAnimationView(name: "loading")
    var typeList = [VehicleType]()
    let cellId = "cellId"
    
    fileprivate func performDataFetch(){
        
        let domain: String  = "https://lubex.esmax.cl"
        let jsonUrlDomain = "\(domain)/webservice/product/filter/?category=\(categoryID)&manufacture=\(manufactureID)&model=\(modelID)"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: jsonUrlDomain, retry: self.performDataFetch) { (response: VehicleTypeResponse) in
            self.typeList = response.type ?? []
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tipo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        performDataFetch()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return typeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let typeObject = typeList[indexPath.row]
        cell.textLabel?.text = typeObject.type
        cell.textLabel?.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        print(typeObject.type as Any)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(typeList[indexPath.row])")
        
        let productController = DetailProductTableController()
    
        productController.categoryID = categoryID
        productController.manufactureID = manufactureID
        productController.modelID = modelID
        productController.typeID = typeList[indexPath.row].id ?? "0"

        navigationController?.pushViewController(productController, animated: true)
    }
    
}
