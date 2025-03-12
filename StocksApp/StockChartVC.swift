//
//  StockChartVC.swift
//  StocksApp
//
//  Created by Asset on 3/12/25.
//

import UIKit

class StockChartVC: UIViewController {
    
    var currentStock: StockDetails?
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFonts.bold.fontFamily, size: 20)
        label.numberOfLines = 1
        label.text = "AAPL"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFonts.semiBold.fontFamily, size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Apple Inc."
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titlesStackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [chartLabel, summaryLabel, newsLabel, forecastsLabel, ideasLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var chartLabel: UILabel = createTitleLabel(text: "Chart", isSelected: true)
    private lazy var summaryLabel: UILabel = createTitleLabel(text: "Summary")
    private lazy var newsLabel: UILabel = createTitleLabel(text: "News")
    private lazy var forecastsLabel: UILabel = createTitleLabel(text: "Forecasts")
    private lazy var ideasLabel: UILabel = createTitleLabel(text: "Ideas")

    private func createTitleLabel(text: String, isSelected: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isSelected ? UIFont(name: CustomFonts.bold.fontFamily, size: 20) : UIFont(name: CustomFonts.regular.fontFamily, size: 16)
        label.textColor = isSelected ? .black : .lightGray
        return label
    }

    private func setupTitlesViewConstraints() {
        view.addSubview(titlesStackview)
        
        NSLayoutConstraint.activate([
            titlesStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlesStackview.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10)
        ])
    }

    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.addTarget(self, action: #selector(backArrowPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(image, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var splitLine: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timeFrameButtons: [UIButton] = {
        let titles = ["D", "W", "M", "6M", "1Y", "All"]
        return titles.enumerated().map { (index, title) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.setTitleColor(index == 5 ? .white : .black, for: .normal) // Highlight 'All' button
            button.backgroundColor = index == 5 ? .black : UIColor.lightGray.withAlphaComponent(0.2)
            button.layer.cornerRadius = 12
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            return button
        }
    }()

    private lazy var timeFrameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: timeFrameButtons)
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private func setupTimeFrameButtonsConstraints() {
        view.addSubview(timeFrameStackView)
        
        NSLayoutConstraint.activate([
            timeFrameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeFrameStackView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -20)
        ])
    }

    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont(name: CustomFonts.semiBold.fontFamily, size: 16)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textColor = .white
        
        button.backgroundColor = .black
        button.setTitle("Buy for $132.04", for: .normal)
        button.layer.cornerRadius = 22
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helper functions
    
    private func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(topView)
        
        topView.addSubview(topTitle)
        topView.addSubview(subTitle)
        topView.addSubview(arrowButton)
        topView.addSubview(starButton)
        topView.addSubview(titlesStackview)
        
        view.addSubview(bottomView)
        
        bottomView.addSubview(buyButton)
        bottomView.addSubview(timeFrameStackView)
    }
    
    private func setupConstraints() {
        let leftRightSpacing = view.frame.width * 0.05
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //TopView elements
            
            subTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            subTitle.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            topTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            topTitle.bottomAnchor.constraint(equalTo: subTitle.topAnchor, constant: -6),
            
            arrowButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: leftRightSpacing),
            arrowButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            arrowButton.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3),
            arrowButton.widthAnchor.constraint(equalTo: arrowButton.heightAnchor),
            
            starButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -leftRightSpacing),
            starButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starButton.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3),
            starButton.widthAnchor.constraint(equalTo: starButton.heightAnchor),
            
            titlesStackview.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: leftRightSpacing),
            titlesStackview.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            
            //BottomView elements
            
            buyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.84),
            buyButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.12),
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            timeFrameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeFrameStackView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -40)
        ])
    }
    
    @objc private func backArrowPressed() {
        dismiss(animated: true, completion: nil)
    }
}

