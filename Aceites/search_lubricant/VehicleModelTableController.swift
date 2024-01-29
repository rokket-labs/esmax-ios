//
//  ModelTableViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit
import Lottie

class VehicleModelTableController: UITableViewController {
    
    
    var categoryID =  String()
    var manufactureID = String()
    var modelID = String()
    var typeID = String()

    var modelList = [VehicleModel]()
    let cellId = "cellId"
    let animationView = LOTAnimationView(name: "loading")
    
    fileprivate func performDataFetch(){
        
        let domain: String  = UserDefaults.standard.string(forKey: "request_url") ?? ""
        let jsonUrlDomain = "\(domain)/webservice/product/filter/?category=\(categoryID)&manufacture=\(manufactureID)"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: jsonUrlDomain, retry: self.performDataFetch) { (response: ModelResponse) in
            self.modelList = response.model ?? []
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        performDataFetch()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let modelObject = modelList[indexPath.row]
        
        cell.textLabel?.text = modelObject.vehicleModel
        cell.textLabel?.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let modelObject =  modelList[indexPath.row]
        let typeVc = VehicleTypeTableController()
        
        typeVc.categoryID = categoryID
        typeVc.manufactureID = manufactureID
        typeVc.modelID = modelObject.id ?? "0"
        
        navigationController?.pushViewController(typeVc, animated: true)
    }
    
}
