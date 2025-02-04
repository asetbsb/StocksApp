//
//  StockCell.swift
//  StocksApp
//
//  Created by Asset on 11/26/24.
//

import UIKit

protocol StarColorDelegate: AnyObject {
    func didTapStar (_ index: IndexPath)
}

final class StockDetailsCell: UITableViewCell {
    
    weak var delegate: StarColorDelegate?
    var stockIndexPath: IndexPath?
    static var identifier = "StockDetailsTableViewСellIdentifier"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stockImage: StockLogoImageView = {
        let image = StockLogoImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 14
        image.image = nil
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: -TopView
    
    private lazy var topView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFonts.bold.fontFamily, size: 20)
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(starPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFonts.bold.fontFamily, size: 20)
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -BottomView
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFonts.semiBold.fontFamily, size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightPriceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: CustomFonts.regular.fontFamily, size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Setting data from ViewController
    
    func set(_ stock: StockDetails, _ indexPath: IndexPath) {
        titleLabel.text = stock.ticker
        stockIndexPath = indexPath
        starButton.imageView?.tintColor = stock.isFavorite.color
        setupUI(with: stock)
    }
    
    private func setupUI(with stock: StockDetails) {
        leftTitle.text = stock.name
        priceLabel.text = stock.currentPrice
        rightPriceLabel.text = stock.priceChange
        rightPriceLabel.textColor = stock.priceChangeColor
        if let imageURL = URL(string: stock.logo) {
            loadImage(from: imageURL)
        }
    }
    
    private func loadImage(from url: URL) {
        stockImage.loadImage(from: url)
    }
    
    //MARK: -Helper functions
    
    private func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        addSubview(containerView)
        
        containerView.addSubview(stockImage)
        containerView.addSubview(topView)
        
        topView.addSubview(titleLabel)
        topView.addSubview(starButton)
        topView.addSubview(priceLabel)
        
        containerView.addSubview(bottomView)
        
        bottomView.addSubview(leftTitle)
        bottomView.addSubview(rightPriceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),

            
            stockImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.78),
            stockImage.widthAnchor.constraint(equalTo: stockImage.heightAnchor),
            stockImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stockImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            topView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            topView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            topView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3),
            topView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            bottomView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 2),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(frame.height * 0.25)),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            //inside topview
            
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            
            starButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            
            priceLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            
            //inside bottomview
            
            leftTitle.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            leftTitle.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            
            rightPriceLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            rightPriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
        ])
    }
    
    //MARK: -Action functions
    
    @objc
    private func starPressed() {
        guard let indexPath = stockIndexPath else {return}
        delegate?.didTapStar(indexPath)
    }
}

