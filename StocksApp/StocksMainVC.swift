//
//  ViewController.swift
//  StocksApp
//
//  Created by Asset on 11/26/24.
//

import UIKit

final class StocksMainVC: UIViewController {
    
    private var stocksList = StocksList()
    
    private var showingFavorites = false
    private var displayedStocksList: [StockDetails] {
        return showingFavorites
            ? stocksList.tickerNames.filter { $0.isFavorite == .favorite }
            : stocksList.tickerNames
    }
    
    //MARK: -UI elements
    
    private lazy var searchBar: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Find company or ticker"
        tf.layer.cornerRadius = 24
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.black.cgColor
        tf.textAlignment = .center
        tf.tintColor = .black

        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tf.addSubview(imageView)


        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: tf.leadingAnchor, constant: 24),
            imageView.centerYAnchor.constraint(equalTo: tf.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: tf.heightAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])

        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()


    
    private lazy var buttonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stocksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stocks", for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(titlePressed(_:)), for: .touchUpInside)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorites", for: .normal)
        button.isSelected = false
        button.addTarget(self, action: #selector(titlePressed(_:)), for: .touchUpInside)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .thin)
        
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stocksTableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(StockDetailsCell.self, forCellReuseIdentifier: StockDetailsCell.identifier)
        
        tv.separatorStyle = .none
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var searchCollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: -Helper Functions
    
    private func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        stocksTableview.delegate = self
        stocksTableview.dataSource = self
        searchBar.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(buttonsView)
        
        buttonsView.addSubview(stocksButton)
        buttonsView.addSubview(favoritesButton)

        view.addSubview(stocksTableview)
    }
    
    private func setupConstraints() {
        let leftRightSpacing = view.frame.width * 0.05
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightSpacing),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightSpacing),
            searchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            
            buttonsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightSpacing),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightSpacing),
            buttonsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            stocksTableview.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 12),
            stocksTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightSpacing),
            stocksTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightSpacing),
            stocksTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            //Inside buttonView
            
            stocksButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            stocksButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            
            favoritesButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 20),
            favoritesButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
        ])
    }
    
    //MARK: -Action Functions
    
    @objc
    private func titlePressed(_ sender: UIButton) {
        showingFavorites = (sender == favoritesButton)
        
        stocksButton.titleLabel?.font = showingFavorites ? UIFont.systemFont(ofSize: 26, weight: .thin) : UIFont.systemFont(ofSize: 32, weight: .bold)
        favoritesButton.titleLabel?.font = showingFavorites ? UIFont.systemFont(ofSize: 32, weight: .bold) : UIFont.systemFont(ofSize: 26, weight: .thin)
        
        stocksButton.isSelected = !showingFavorites
        favoritesButton.isSelected = showingFavorites
        
        stocksTableview.reloadData()
    }
}

extension StocksMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedStocksList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockDetailsCell.identifier) as? StockDetailsCell else {
            return UITableViewCell()
        }

        let stock = displayedStocksList[indexPath.row]

        cell.set(stock, indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.1
    }
}

extension StocksMainVC: StarColorDelegate {
    func didTapStar(_ index: IndexPath) {
        var stock = displayedStocksList[index.row]
        
        if let originalIndex = stocksList.tickerNames.firstIndex(where: { $0.ticker == stock.ticker }) {
            let stockToUpdate = stocksList.tickerNames[originalIndex]
            stocksList.tickerNames[originalIndex].isFavorite = stockToUpdate.isFavorite == .favorite ? .notFavorite : .favorite
        }
        
        if showingFavorites {
            stocksTableview.reloadData()
        } else {
            stocksTableview.reloadRows(at: [index], with: .automatic)
        }
    }
}

extension StocksMainVC: UITextFieldDelegate {
    
}
