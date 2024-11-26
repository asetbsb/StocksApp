//
//  StockCell.swift
//  StocksApp
//
//  Created by Asset on 11/26/24.
//

import UIKit

protocol StarColorDelegate: AnyObject {
    func didTapStar (_ index: Int, _ color: UIColor)
}

final class StockCell: UITableViewCell {
    
    weak var delegate: StarColorDelegate?
    
    var stockIndex: Int?
    
    static var identifier = "TableViewCellIdentifier"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        
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
        label.text = "YNDX"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.addTarget(self, action: #selector(starPressed(_:)), for: .touchUpInside)
        button.tintColor = .yellow
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "4000"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        
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
        label.text = "Yandex, LLC"
        label.font = .systemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 1000"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .green
        
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
    
    //MARK: -Helper functions
    
    private func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        addSubviews()
        setConstraints()
    }
    
    func set(_ stock: StockStruct, _ index: Int) {
        titleLabel.text = stock.name
        if stock.isFavorite {
            starButton.tintColor = .yellow
        } else {
            starButton.tintColor = .lightGray
        }
        stockIndex = index
    }
    
    private func addSubviews() {
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
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stockImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
            stockImage.widthAnchor.constraint(equalTo: stockImage.heightAnchor),
            stockImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stockImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            topView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            topView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: frame.height * 0.1),
            topView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            topView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            bottomView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 4),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -frame.height * 0.1),
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
    private func starPressed(_ sender: UIButton) {
        print("star pressed")
        if sender.tintColor == .lightGray {
            sender.tintColor = .yellow
            delegate?.didTapStar(stockIndex ?? 0, .yellow)
        } else {
            sender.tintColor = .lightGray
            delegate?.didTapStar(stockIndex ?? 0, .lightGray)
        }
    }
}
