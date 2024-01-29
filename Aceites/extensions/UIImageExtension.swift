//
//  UIImageExtension.swift
//  HelpHub
//
//  Created by Eddwin Paz on 2/21/17.
//  Copyright © 2017 HelpHub Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
    
        }
    }
}

extension UIImage {
    
    var pngRepresentationData: Data? {
        return self.pngData()
    }
}


extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {

        //print("downloading...")
        //print(urlString)

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                //print(error ?? "Imagen Vacia")
                self.image = UIImage(named: "00")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()

    }


    public func maskCircle(anyImage: UIImage) {

        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true

        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        //self.image = prepareImage(anyImage)
    }

}
