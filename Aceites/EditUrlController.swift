//
//  EditUrlController.swift
//  Aceites
//
//  Created by Eddwin Paz on 1/29/19.
//  Copyright © 2019 Esmax. All rights reserved.
//

import UIKit

class EditUrlController: UIViewController, UITextFieldDelegate{
    
    let sampleTextField = UITextField()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Editar URL"
        self.view.backgroundColor = UIColor.white
        
        let domain:String  = UserDefaults.standard.string(forKey: "request_url") ?? ""
        print(domain)


        // Create textfield
        sampleTextField.frame = CGRect(x: 20, y: 100, width: self.view.frame.width-40, height: 40)
        sampleTextField.placeholder = "Enter URl"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        sampleTextField.text = domain
        sampleTextField.autocapitalizationType = .none
//        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sampleTextField)
        
        // Create save button
        button.frame = CGRect(x: 20, y: 150, width: self.view.frame.width-40, height: 50)
        button.backgroundColor = .gray
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
//        let sampleTextFieldConstraint = [
//            sampleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0),
//            sampleTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
//            sampleTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0),
//            ]
//        NSLayoutConstraint.activate(sampleTextFieldConstraint)
//        
//        let buttonConstraint = [
//            button.topAnchor.constraint(equalTo: sampleTextField.bottomAnchor, constant: 10.0),
//            button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
//            button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0),
//            ]
//        NSLayoutConstraint.activate(buttonConstraint)
        
        
    }
    
    @objc  func buttonAction(){
        print("saved. \(sampleTextField.text ?? "")")
        UserDefaults.standard.set(sampleTextField.text, forKey: "request_url") //setObject
        // self.alert(message: "Cambios fueron guardados!")
        
        let alert = UIAlertController(title: "Notificación",
                                      message: "Cambios fueron modificados correctamente.",
                                      preferredStyle: .alert)
        
         alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
