//
//  FileViewController.swift
//  Aceites
//
//  Created by Eddwin Paz on 11/6/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import UIKit

class FileViewController: UIViewController {
    
    var file_url: String? {
        didSet {
            let myUrl = URLRequest(url: (URL(string: file_url ?? "") ?? nil)!)
            pdfView.loadRequest(myUrl)
        }
    }
    let pdfView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pdfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pdfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
