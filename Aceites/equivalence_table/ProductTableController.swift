//
//  ProductTableController.swift
//  Aceites
//
//  Created by Eddwin Paz on 12/4/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit
import Lottie


class ProductTableController: UITableViewController {
    
    var companyList = [CompanyObject]()
    var company_id = String()
    
    let cellId = "cellId"
    let animationView = LOTAnimationView(name: "loading")
    
    fileprivate func performDataFetch(){
        
        let domain: String  = "https://lubex.esmax.cl"
        let jsonUrlDomain = "\(domain)/webservice/company/\(company_id)"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self ,urlString: jsonUrlDomain, retry: self.performDataFetch) {
            (response: CompanyResponse) in
            self.companyList = response.companyProduct ?? []
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        performDataFetch()
        self.title = "Productos"
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return companyList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let modelObject = companyList[indexPath.row]
        
        cell.textLabel?.text = modelObject.name
        cell.textLabel?.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailvc = ViewProductTableViewController()
        let company = companyList[indexPath.row]
        detailvc.product = company.product
        detailvc.is_datasheet = false
        navigationController?.pushViewController(detailvc, animated: true)
        
    }

}
