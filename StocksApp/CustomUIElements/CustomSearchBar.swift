//
//  CustomSearchBar.swift
//  StocksApp
//
//  Created by Asset on 1/24/25.
//

import UIKit

class CustomSearchBar: UITextField {
    
    let glassImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    let clearButton = UIButton()
    let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.left"))
    
    func setupUI() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        textAlignment = .center
        tintColor = .black
        
        font = UIFont(name: CustomFonts.semiBold.fontFamily, size: 18)
        
        attributedPlaceholder = NSAttributedString(
            string: "Find company or ticker",
            attributes: [
                .font: UIFont(name: CustomFonts.semiBold.fontFamily, size: 18) ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ]
        )
        
        clearButtonMode = .never
        rightViewMode   = .whileEditing

        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.contentMode = .scaleAspectFit
        clearButton.tintColor = .black
        clearButton.translatesAutoresizingMaskIntoConstraints = false

        glassImageView.contentMode = .scaleAspectFit
        glassImageView.tintColor = .black
        glassImageView.translatesAutoresizingMaskIntoConstraints = false
        
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .black
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addGlassImage()
    }
    
    func removeClearButton() {
        clearButton.removeFromSuperview()
    }
    
    func addClearButton() {
        addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            clearButton.heightAnchor.constraint(equalTo: clearButton.widthAnchor)
        ])
    }
    
    func addGlassImage() {
        addSubview(glassImageView)

        NSLayoutConstraint.activate([
            glassImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            glassImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            glassImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            glassImageView.heightAnchor.constraint(equalTo: glassImageView.widthAnchor)
        ])
    }
    
    func removeGlassImage() {
        glassImageView.removeFromSuperview()
    }
    
    func addArrowImage() {
        addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            arrowImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            arrowImageView.heightAnchor.constraint(equalTo: arrowImageView.widthAnchor)
        ])
    }
    
    func removeArrowImage() {
        arrowImageView.removeFromSuperview()
    }
}
