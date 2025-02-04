//
//  StockLogoImageView.swift
//  StocksApp
//
//  Created by Asset on 1/23/25.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class StockLogoImageView: UIImageView {
    var task: URLSessionDataTask!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL) {
        image = nil
        
        addActivityIndicator()
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeActivityIndicator()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
              let data = data,
              let newImage = UIImage(data: data)
            else {
                print("Couldn't load image from url")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeActivityIndicator()
            }
        }
        
        task.resume()
    }
    
    func addActivityIndicator() {
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
}
