//
//  ListFaqsViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/25/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ListFaqTableController: UITableViewController {
    
    let cellId = "cellId"
    var questions = [Faq]()
    let animationView = LOTAnimationView(name: "loading")
    
    override func viewWillAppear(_ animated: Bool) {
                tableView.rowHeight = UITableView.automaticDimension
                tableView.estimatedRowHeight = 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Preguntas Frecuentes"
        tableView.register(FaqTableViewCell.self, forCellReuseIdentifier: cellId)
        performDataFetch()
    }
    
    fileprivate func performDataFetch(){
        let domain: String  = UserDefaults.standard.string(forKey: "request_url") ?? ""
        let urlString = "\(domain)/webservice/faq/"
        
        putInLoadingState(table: self.tableView, view: self.view, lottieAnimationView:self.animationView )
        fetchGenericData(view: self, urlString: urlString, retry: self.performDataFetch) { (response:FaqResponse) in
           self.questions = response.faq ?? []
           putInFinishedLoading(table: self.tableView, lottieAnimationView:self.animationView )
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FaqTableViewCell
        let question = questions[indexPath.row]
        cell.questionLabel.text =  question.question
        cell.questionLabel.textColor = UIColor(red: 0.396, green: 0.4, blue: 0.431, alpha: 1.0)
        cell.questionLabel.font = UIFont.systemFont(ofSize: 19)
        

        cell.accessoryType = .disclosureIndicator
        print(question.question as Any)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(questions[indexPath.row])")
        
        let width: CGFloat = 300
        let height: CGFloat = 500
        
        print("width: ", width)
        print("height: ", height)
        print("x: ", height/2)
        
        let question: Faq = questions[indexPath.row]
        
        let detailvc = DetailFaqController()
        detailvc.question = question

        navigationController?.pushViewController(detailvc, animated: true)
    }
}


class FaqTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(questionLabel)
        let constrains = [questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        questionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
        questionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)]
        NSLayoutConstraint.activate(constrains)
    }
}

