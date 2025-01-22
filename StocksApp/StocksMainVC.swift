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
    
    private var searchBarHeightConstraint: NSLayoutConstraint?
    private var searchBarHeight: CGFloat = 100
    private var isAnimationInProgress = false
    
    //MARK: -UI elements
    
    private lazy var searchBar: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = view.frame.height * 0.035
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.black.cgColor
        tf.textAlignment = .center
        tf.tintColor = .black
        
        tf.attributedPlaceholder = NSAttributedString(
            string: "Find company or ticker",
            attributes: [
                .font: UIFont(name: CustomFonts.semiBold.fontFamily, size: 18) ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ]
        )

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
        
        button.titleLabel?.font = UIFont(name: CustomFonts.bold.fontFamily, size: 28)
        
        button.isSelected = true
        button.addTarget(self, action: #selector(titlePressed(_:)), for: .touchUpInside)
        
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorites", for: .normal)
        
        button.titleLabel?.font = UIFont(name: CustomFonts.regular.fontFamily, size: 20)
        
        button.isSelected = false
        button.addTarget(self, action: #selector(titlePressed(_:)), for: .touchUpInside)
        
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stocksTableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(StockDetailsCell.self, forCellReuseIdentifier: StockDetailsCell.identifier)
        tv.showsVerticalScrollIndicator = false
        tv.sectionHeaderTopPadding = 10
        
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
        let titlesSpacing = view.frame.width * 0.07
        
        searchBarHeight = view.frame.height * 0.07
        searchBarHeightConstraint = searchBar.heightAnchor.constraint(equalToConstant: searchBarHeight)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightSpacing),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightSpacing),
            searchBarHeightConstraint!,
            
            buttonsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titlesSpacing),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -titlesSpacing),
            
            stocksTableview.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 16),
            stocksTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightSpacing),
            stocksTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightSpacing),
            stocksTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Inside buttonView
            
            stocksButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            stocksButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            stocksButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            
            favoritesButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 20),
            favoritesButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            favoritesButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor)
        ])
    }
    
    //MARK: -Action Functions
    
    @objc
    private func titlePressed(_ sender: UIButton) {
        showingFavorites = (sender == favoritesButton)
        
        stocksButton.titleLabel?.font = showingFavorites ? UIFont(name: CustomFonts.regular.fontFamily, size: 20) : UIFont(name: CustomFonts.bold.fontFamily, size: 28)
        favoritesButton.titleLabel?.font = showingFavorites ? UIFont(name: CustomFonts.bold.fontFamily, size: 28) : UIFont(name: CustomFonts.regular.fontFamily, size: 20)
        
        stocksButton.isSelected = !showingFavorites
        favoritesButton.isSelected = showingFavorites
        
        stocksTableview.reloadData()
    }
}

    //MARK: -Extensions

extension StocksMainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedStocksList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockDetailsCell.identifier) as? StockDetailsCell else {
            return UITableViewCell()
        }

        let stock = displayedStocksList[indexPath.section]
        cell.set(stock, indexPath)
        cell.delegate = self
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = UIColor(rgb: 0xF0F4F7)
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stocksTableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the animation is locked or not
        if !isAnimationInProgress {
            guard let searchBarHeightConstraint = searchBarHeightConstraint else { return }

            // Check if an animation is required
            if scrollView.contentOffset.y > 0 &&
                searchBarHeightConstraint.constant > 0 {

                searchBarHeightConstraint.constant = 0
                animateTopViewHeight()
            }
            else if scrollView.contentOffset.y <= 0 &&
                        searchBarHeightConstraint.constant <= 0 {

                searchBarHeightConstraint.constant = searchBarHeight
                animateTopViewHeight()
            }
        }
    }

    private func animateTopViewHeight() {
        isAnimationInProgress = true

        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.isAnimationInProgress = false
        }
    }
}

extension StocksMainVC: StarColorDelegate {
    func didTapStar(_ index: IndexPath) {
        let stock = displayedStocksList[index.section]
        
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
