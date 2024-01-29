//
//  IndexTableController.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/1/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class IndexTableController: UITableViewController {
    
    var arrayList = ["1":["1"], "2": ["2"]]
    var menuOptions = [String: [String]]()
    var productList = [ProductObject]()
    
    fileprivate func setupTitle(){
        
        let logo = UIImage(named: "lubrax_logo")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRect(x: 0, y: -25, width: 150, height: 80)
        imageView.contentMode = .scaleAspectFit
        
        let logoView = UIView(frame: CGRect(x: 10, y: 0, width: 150, height: 80))
        logoView.addSubview(imageView)

        self.navigationItem.titleView = logoView
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    fileprivate func getProductData(){
        // Get local Data
        let favoritos = getFavorites()
        let domain: String  = "https://lubex.esmax.cl"
        let jsonUrlDomain = "\(domain)/webservice/product/?limit=6&random=1"
        
        if (favoritos != nil) {
            
            print("total favoritos: \(String(describing: favoritos?.count))")
            
            // Decide weather it should load remte or local data
            if ((favoritos?.count)! == 0 ){
 
                fetchGenericData(view: self ,urlString: jsonUrlDomain, retry: self.getProductData) {
                    (response: ProductResponse) in
                    self.productList = response.product ?? []
                    self.tableView.reloadData()
                }
                
            } else {
                print("Display information from local data...")
                self.productList = favoritos ?? []
                self.tableView.reloadData()
            }
        } else {
            
            fetchGenericData(view: self ,urlString: jsonUrlDomain, retry: self.getProductData) {
                (response: ProductResponse) in
                self.productList = response.product ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "cellIdProduct")
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cellIdMenu")
        tableView.register(RowMenuTableViewCell.self, forCellReuseIdentifier: "RowMenuTableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor  =  UIColor.white //UIColor(red: 0.953, green: 0.957, blue: 0.965, alpha: 1.0)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        
        setupTitle()
        getProductData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ?  1 :  5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 250 : 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
        if indexPath.section == 1{
            if indexPath.row == 0 {
                // Search Lubricants
                navigationController?.pushViewController(VehicleCategoryTableController(), animated: true)
            }
            if indexPath.row == 1 {
                // Datasheets
                navigationController?.pushViewController(ListDatasheetTableController(), animated: true)
            }
            
            if indexPath.row == 2 {
                // Equivalence Table
                navigationController?.pushViewController(MotorTypeController(), animated: true)
            }
            
            if indexPath.row == 3 {
                // Faq's
                navigationController?.pushViewController(ListFaqTableController(), animated: true)
            }
            
            if indexPath.row == 4 {
                // Faq's
                navigationController?.pushViewController(EditUrlController(), animated: true)
            }
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdProduct", for: indexPath) as! ProductTableViewCell
            cell.selectionStyle = .none
            cell.navControl = self.navigationController
            cell.productList = productList
            return cell
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowMenuTableViewCell", for: indexPath) as! RowMenuTableViewCell
                cell.menuImageView.image = UIImage(named: "search")
                cell.menuLabelTitle.text = "Buscador Lubricantes"
                cell.menuLabelSubTitle.text = "Encuentra lubricante adecuado para tu vehículo"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none

                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowMenuTableViewCell", for: indexPath) as! RowMenuTableViewCell
                cell.menuImageView.image = UIImage(named: "datasheet")
                cell.menuLabelTitle.text = "Fichas Técnicas"
                cell.menuLabelSubTitle.text = "Encuentra las especificaciones de nuestros productos"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none

                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowMenuTableViewCell", for: indexPath) as! RowMenuTableViewCell
                cell.menuImageView.image = UIImage(named: "table")
                cell.menuLabelTitle.text = "Tabla Equivalencias"
                cell.menuLabelSubTitle.text = "Compara nuestros productos con los de la competencia"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none

                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowMenuTableViewCell", for: indexPath) as! RowMenuTableViewCell
                cell.menuImageView.image = UIImage(named: "faq")
                cell.menuLabelTitle.text = "Preguntas Frecuentes"
                cell.menuLabelSubTitle.text = "Encuentra respuestas rapidas a tus dudas"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none

                return cell
            }
                
            else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowMenuTableViewCell", for: indexPath) as! RowMenuTableViewCell
                cell.menuImageView.image = UIImage(named: "faq")
                cell.menuLabelTitle.text = "Editar Url"
                cell.menuLabelSubTitle.text = "Modifica la URL de la app"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                
                return cell
            }
            
            
            else {
                let cell = UITableViewCell()
                return cell
            }
            
            
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
}


class RowMenuTableViewCell: UITableViewCell {
    
    let menuImageView: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.red
        return label
    }()
    
    let menuLabelTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22).bold()
        label.textColor = UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0) //UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        label.backgroundColor = UIColor.blue
        return label
    }()
    
    let menuLabelSubTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.773, green: 0.776, blue: 0.773, alpha: 1.0) //UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        label.backgroundColor = UIColor.red
        return label
    }()
    
    func setupViews(){
        // imageView
        addSubview(menuImageView)
        let imageViewconstrains = [menuImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
                                   menuImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                                   menuImageView.heightAnchor.constraint(equalToConstant: 90.0),
                                   menuImageView.widthAnchor.constraint(equalToConstant: 90.0)]
        NSLayoutConstraint.activate(imageViewconstrains)
        
        // menuOptionName
        addSubview(menuLabelTitle)
        let menuOptionNameconstrains = [menuLabelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
                                      menuLabelTitle.leftAnchor.constraint(equalTo: menuImageView.rightAnchor, constant: 10.0)]
        NSLayoutConstraint.activate(menuOptionNameconstrains)
        
        // menuLabelSubTitle
        addSubview(menuLabelSubTitle)
        let menuLabelSubTitleconstrains = [menuLabelSubTitle.topAnchor.constraint(equalTo: menuLabelTitle.topAnchor, constant: 30.0),
                                           menuLabelSubTitle.leftAnchor.constraint(equalTo: menuImageView.rightAnchor, constant: 10.0),
                                           menuLabelSubTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30.0)]
        NSLayoutConstraint.activate(menuLabelSubTitleconstrains)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
