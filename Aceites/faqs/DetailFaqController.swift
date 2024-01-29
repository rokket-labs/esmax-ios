//
//  PopVcViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/26/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class DetailFaqController: UIViewController {
    
    var question: Faq! {
        didSet {
            navigationItem.title = "Respuesta"
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(34).bold()
        label.textColor =  UIColor(red: 0.176, green: 0.561, blue: 0.345, alpha: 1.0)
        return label
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Answer"
        label.numberOfLines = 0
        label.font = label.font.withSize(18)
        label.textColor = UIColor(red: 0.498, green: 0.608, blue: 0.675, alpha: 1.0)//UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.96, alpha:1.0)
        
//        let ww = CAGradientLayer()
//        ww.frame = CGRect(x: 0, y: 290, width: self.view.frame.width, height: self.view.frame.height)
//        ww.colors = [UIColor.white.cgColor, UIColor(red: 0.259, green: 0.816, blue: 0.502, alpha: 1.0).cgColor]
//        self.view.layer.addSublayer(ww)

        questionLabel.text =  question.question
        answerLabel.text = question.answer
        
        setupScrollView()
        setupLayout()

    }
    
    fileprivate func setupScrollView(){
        scrollView.contentSize.height = 1000
        view.addSubview(scrollView)
        scrollView.addSubview(questionLabel)
        scrollView.addSubview(answerLabel)
    }

    
    fileprivate func setupLayout(){
        
        let scrollViewConstrains = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstrains)
        
        let constrainsQuestion = [
            questionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            questionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15)
        ]
        NSLayoutConstraint.activate(constrainsQuestion)
        
        let constrainsAnswer = [
            answerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            answerLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15),
        ]

        NSLayoutConstraint.activate(constrainsAnswer)

    
    }
    


}
