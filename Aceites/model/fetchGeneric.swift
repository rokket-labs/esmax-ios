//
//  fetchGeneric.swift
//  Aceites
//
//  Created by Eddwin Paz on 2/4/19.
//  Copyright © 2019 Esmax. All rights reserved.
//

import Foundation
import UIKit
import Lottie

 func putInLoadingState(table: UITableView, view: UIView, lottieAnimationView: LOTAnimationView){
//    table.separatorStyle = .none
//    view.addSubview(activityIndicator)
//    activityIndicator.frame = view.bounds
//    activityIndicator.startAnimating()
//    table.reloadData()
    
    table.separatorStyle = .none
    lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lottieAnimationView)
    lottieAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    lottieAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50.0).isActive = true
    lottieAnimationView.heightAnchor.constraint(equalToConstant: 600).isActive = true
    lottieAnimationView.widthAnchor.constraint(equalToConstant: 600).isActive = true
    lottieAnimationView.play()
    lottieAnimationView.loopAnimation = true
    table.reloadData()
    
}
 func putInFinishedLoading(table: UITableView, lottieAnimationView: LOTAnimationView){
    lottieAnimationView.removeFromSuperview()
    table.separatorStyle = .singleLine
    table.reloadData()
    
}

func fetchGenericData<T: Decodable>(view: UIViewController, urlString: String, retry: @escaping () -> Void, completion: @escaping (T) -> ()){
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, err) in
        DispatchQueue.main.async {
            if let err = err {
                print("Failed to get data from url:", err)
                    let alert = UIAlertController(title: "Notificación",
                                                  message: "No se pudo obtener la información solicitada, desa intentar de nuevo?",
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                        print("Requesting information again")
                        retry()
                    }))
                    
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                        view.navigationController?.popToRootViewController(animated: true)
                    }))
                    view.present(alert, animated: true)
                
                
                return
            }
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let obj = try decoder.decode(T.self, from: data)
                completion(obj)
                
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
                
                let alert = UIAlertController(title: "Notificación",
                                              message: "No se pudo obtener la información solicitada, desa intentar de nuevo?",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                    print("Requesting information again")
                    retry()
                }))
                
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                    view.navigationController?.popToRootViewController(animated: true)
                }))
                view.present(alert, animated: true)
                
            }
        }
        }.resume()
}
   
