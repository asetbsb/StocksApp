import Foundation
import UIKit

class EmptySearchView: UIView {

    let popularRequestsLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular requests"
        label.font = UIFont(name: CustomFonts.bold.fontFamily, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let searchedRequestsLabel: UILabel = {
        let label = UILabel()
        label.text = "You’ve searched for this"
        label.font = UIFont(name: CustomFonts.bold.fontFamily, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var firstScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    lazy var firstVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var secondScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    lazy var secondVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var popularRequests = ["Apple", "Amazon", "Google", "Tesla", "Microsoft", "Alibaba"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupStackViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(popularRequestsLabel)
        addSubview(firstScroll)
        firstScroll.addSubview(firstVerticalStack)
        addSubview(searchedRequestsLabel)
        addSubview(secondScroll)
        secondScroll.addSubview(secondVerticalStack)
    }

    private func setupStackViews() {
        populateVerticalStackView(firstVerticalStack, with: popularRequests)
        updateSearchHistory()
    }

    private func populateVerticalStackView(_ verticalStackView: UIStackView, with items: [String]) {
        let row1 = UIStackView()
        row1.axis = .horizontal
        row1.spacing = 8

        let row2 = UIStackView()
        row2.axis = .horizontal
        row2.spacing = 8

        for (index, text) in items.enumerated() {
            let label = createTagLabel(text: text)
            if index < items.count / 2 {
                row1.addArrangedSubview(label)
            } else {
                row2.addArrangedSubview(label)
            }
        }

        verticalStackView.addArrangedSubview(row1)
        verticalStackView.addArrangedSubview(row2)
    }

    private func createTagLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: CustomFonts.semiBold.fontFamily, size: 15)
        label.textAlignment = .center
        label.backgroundColor = AppColors.greyColor.color
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true

        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let padding = label.intrinsicContentSize.width + 35
        label.widthAnchor.constraint(equalToConstant: padding).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            popularRequestsLabel.topAnchor.constraint(equalTo: topAnchor),
            popularRequestsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            firstScroll.topAnchor.constraint(equalTo: popularRequestsLabel.bottomAnchor, constant: 12),
            firstScroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstScroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstScroll.heightAnchor.constraint(equalToConstant: 120),

            firstVerticalStack.topAnchor.constraint(equalTo: firstScroll.topAnchor),
            firstVerticalStack.leadingAnchor.constraint(equalTo: firstScroll.leadingAnchor),
            firstVerticalStack.trailingAnchor.constraint(equalTo: firstScroll.trailingAnchor),
            firstVerticalStack.bottomAnchor.constraint(equalTo: firstScroll.bottomAnchor),

            searchedRequestsLabel.topAnchor.constraint(equalTo: firstScroll.bottomAnchor, constant: 20),
            searchedRequestsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            secondScroll.topAnchor.constraint(equalTo: searchedRequestsLabel.bottomAnchor, constant: 12),
            secondScroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondScroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondScroll.heightAnchor.constraint(equalToConstant: 120),

            secondVerticalStack.topAnchor.constraint(equalTo: secondScroll.topAnchor),
            secondVerticalStack.leadingAnchor.constraint(equalTo: secondScroll.leadingAnchor),
            secondVerticalStack.trailingAnchor.constraint(equalTo: secondScroll.trailingAnchor),
            secondVerticalStack.bottomAnchor.constraint(equalTo: secondScroll.bottomAnchor)
        ])
    }

    func updateSearchHistory() {
        let searchHistory = CoreDataManager.shared.fetchSearchHistory()
        secondVerticalStack.arrangedSubviews.forEach { $0.removeFromSuperview() } 
        populateVerticalStackView(secondVerticalStack, with: searchHistory)
    }
}

