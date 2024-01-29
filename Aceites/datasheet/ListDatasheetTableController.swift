//
//  ListDatasheetTableController.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/5/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit
import Lottie

class ListDatasheetTableController: UITableViewController, UISearchResultsUpdating {
    
    
    var productList = [ProductObject]()
    var productFilteredList = [ProductObject]()
    var searchController: UISearchController!
    let animationView = LOTAnimationView(name: "loading")
    
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            print("sending search term")
            filterRowsForSearchedText(term)
        }
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        productFilteredList = productList.filter({( model : ProductObject) -> Bool in
            return model.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        tableView.reloadData()
    }
     
    fileprivate func performFetchData(){
        
        let domain: String  = UserDefaults.standard.string(forKey: "request_url") ?? ""
        let jsonUrlDomain = "\(domain)/webservice/product/?unique=1"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: jsonUrlDomain, retry: self.performFetchData) { (response:ProductResponse) in
            self.productList = response.product ?? []
            self.searchController.searchBar.isUserInteractionEnabled = true
            putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "products")
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Buscar nombre producto"
        searchController.searchBar.barTintColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        searchController.searchBar.isUserInteractionEnabled = false
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        self.title = "Productos"
        self.performFetchData()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return productFilteredList.count
        }
        return productList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "products", for: indexPath) as UITableViewCell
        
        let product: ProductObject
        if searchController.isActive && searchController.searchBar.text != "" {
            product = productFilteredList[indexPath.row]
        } else {
            product = productList[indexPath.row]
        }
        
        cell.textLabel?.text = String(product.name ?? "No Disponible")
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product: ProductObject
        if searchController.isActive && searchController.searchBar.text != "" {
            product = productFilteredList[indexPath.row]
        } else {
            product = productList[indexPath.row]
        }
        
        let detailvc = ViewProductTableViewController()
        detailvc.product = product
        detailvc.is_datasheet = false
        navigationController?.pushViewController(detailvc, animated: true)
    }
}
