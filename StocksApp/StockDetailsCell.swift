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
    
    private var networkingManager = NetworkingManager()
    
    weak var delegate: StarColorDelegate?
    var stockIndexPath: IndexPath?
    static var identifier = "StockDetailsTableViewСellIdentifier"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stockImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        
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
        label.textColor = UIColor(rgb: 0x1A1A1A)
        label.font = UIFont(name: "Montserrat-VariableFont_wght", size: 22)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.addTarget(self, action: #selector(starPressed), for: .touchUpInside)
        button.tintColor = .lightGray
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-VariableFont_wght", size: 22)
        label.textColor = UIColor(rgb: 0x1A1A1A)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
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
        label.font = UIFont(name: "Montserrat-VariableFont_wght", size: 16)
        label.textColor = UIColor(rgb: 0x000000)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightPriceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Montserrat-VariableFont_wght", size: 16)
        label.textColor = UIColor(rgb: 0x24B25D)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupUI()
    }
    
    override func prepareForReuse() {
        stockImage.image = nil
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
    
    func set(_ stock: StockDetails, _ indexPath: IndexPath) {
        titleLabel.text = stock.ticker
        stockIndexPath = indexPath
        starButton.tintColor = stock.isFavorite.color
        setupNetworking(stock.ticker)
    }
    
    func setupNetworking(_ ticker: String) {
        networkingManager.fetchData(type: .logoName(ticker), responseType: StockLogoNameData.self) { result in
            switch result {
            case .success(let data):
                self.uploadPhotoURL(data.logo)
                DispatchQueue.main.async {
                    self.leftTitle.text = data.name
                }
            case .failure(let error):
                print("Error fetching logo: \(error)")
            }
        }

        networkingManager.fetchData(type: .prices(ticker), responseType: StockPriceData.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.priceLabel.text = "$" + String(data.currentPrice)
                    self.rightPriceLabel.text = "+$" + String(data.priceChange)
                }
            case .failure(let error):
                print("Error fetching stock info: \(error)")
            }
        }
    }
    
    func uploadPhotoURL(_ imageURL: String) {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self, let data = data, error == nil,
                      let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.stockImage.image = image
                }
            }.resume()
        }
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
            
            stockImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.85),
            stockImage.widthAnchor.constraint(equalTo: stockImage.heightAnchor),
            stockImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stockImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            topView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            topView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: frame.height * 0.25),
            topView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.25),
            topView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            bottomView.leadingAnchor.constraint(equalTo: stockImage.trailingAnchor, constant: 10),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 4),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -frame.height * 0.25),
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

