//
//  CarModelTBC.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/20/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit
import Lottie


struct wordDictionary {
    let brand: String?
    let uniqueId: String?
    let index: String?
}

class VehicleManufactureTableController: UITableViewController, UISearchBarDelegate {
    
    var car: Car! {
        didSet {
            navigationItem.title = car.name
        }
    }
    
    var categoryID =  String()
    var manufactureID = String()
    var modelID = String()
    var typeID = String()
    
    
    let cellId = "cellId"
    var manufactureList = [VehicleManufacture]()
    var wordSection = [String]()
    var wordDict = [String: [String]]()
    var vehicleDictionary = [String: [VehicleModelIndex]]()
    var wordDictObject = [VehicleModelIndex]()
    let animationView = LOTAnimationView(name: "loading")
    
    func generateWordDict(){
        
        for word in manufactureList {
            
            let brand: String = word.brand!
            let key = "\(brand[brand.startIndex])"
            let lower =  key.capitalized //key.lowercased()

            if var wordVal = vehicleDictionary[lower]{
                wordVal.append(VehicleModelIndex(uniqueId: word.id, vehicleModel: word.brand))
                vehicleDictionary[lower] = wordVal
            } else {
                vehicleDictionary[lower] = [VehicleModelIndex(uniqueId: word.id, vehicleModel: word.brand)]
            }
        }
        wordSection = [String](vehicleDictionary.keys)
        wordSection = wordSection.sorted()
    }
    
    fileprivate func performFetchData(){
        
        let category: String = car.id
        let domain: String  = UserDefaults.standard.string(forKey: "request_url") ?? ""
        let jsonUrlDomain = "\(domain)/webservice/product/filter/?category=\(category)"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: jsonUrlDomain, retry: self.performFetchData) { (response: ManufactureResponse) in
            self.manufactureList = response.manufacture ?? []
            self.generateWordDict()
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        performFetchData()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let wordKey = wordSection[section]
        
        if let wordValues = vehicleDictionary[wordKey] {
            return wordValues.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let wordKey = wordSection[indexPath.section]
        cell.textLabel?.text = vehicleDictionary[wordKey]![indexPath.row].vehicleModel
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.textLabel?.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let wordKey = wordSection[indexPath.section]
        let manufactureObject = vehicleDictionary[wordKey]![indexPath.row]
        
        let modelVc = VehicleModelTableController()
        modelVc.manufactureID = manufactureObject.uniqueId ?? "0"
        modelVc.categoryID = car.id
        modelVc.title = "Modelo - " + ((manufactureObject.vehicleModel as String?)!)
        
        navigationController?.pushViewController(modelVc, animated: true)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordSection
    }
    
    
    
}
