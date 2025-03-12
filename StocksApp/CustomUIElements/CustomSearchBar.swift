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
    let arrowButton = UIButton()
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let convertedClearButtonPoint = clearButton.convert(point, from: self)
        if clearButton.bounds.contains(convertedClearButtonPoint) {
            return clearButton
        }

        let convertedArrowButtonPoint = arrowButton.convert(point, from: self)
        if arrowButton.bounds.contains(convertedArrowButtonPoint) {
            return arrowButton
        }

        return super.hitTest(point, with: event)
    }

    
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

        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.contentMode = .scaleAspectFit
        clearButton.tintColor = .black
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.isUserInteractionEnabled = true

        glassImageView.contentMode = .scaleAspectFit
        glassImageView.tintColor = .black
        glassImageView.translatesAutoresizingMaskIntoConstraints = false
        
        arrowButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        arrowButton.contentMode = .scaleAspectFit
        arrowButton.tintColor = .black
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.isUserInteractionEnabled = true

        addImages()
    }
    
    func addImages() {
        addSubview(glassImageView)
        addSubview(arrowButton)
        addSubview(clearButton)
        
        setConstraints()
        bringSubviewToFront(clearButton)
        bringSubviewToFront(arrowButton)
        
        clearButton.isHidden = true
        arrowButton.isHidden = true
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            clearButton.heightAnchor.constraint(equalTo: clearButton.widthAnchor),
            
            glassImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            glassImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            glassImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            glassImageView.heightAnchor.constraint(equalTo: glassImageView.widthAnchor),
            
            arrowButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            arrowButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            arrowButton.heightAnchor.constraint(equalTo: arrowButton.widthAnchor)
        ])
    }
    
    func togglePlaceholder(isEmpty: Bool) {
        if isEmpty {
            placeholder = ""
        } else {
            attributedPlaceholder = NSAttributedString(
                string: "Find company or ticker",
                attributes: [
                    .font: UIFont(name: CustomFonts.semiBold.fontFamily, size: 18) ?? UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.black
                ]
            )
        }
    }
    
    func toggleImages(isSearchEmpty: Bool) {
        glassImageView.isHidden = isSearchEmpty ? false : true
        clearButton.isHidden = isSearchEmpty ? true : false
        arrowButton.isHidden = isSearchEmpty ? true : false
    }
}
