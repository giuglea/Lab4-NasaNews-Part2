//
//  SearchArticleTableViewCell.swift
//  NasaNews
//
//  Created by Tzy on 25.03.2022.
//

import UIKit

final class SearchArticleTableViewCell: UITableViewCell {
    static let cellId = "SearchArticleTableViewCell"
    
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(ratingLabel)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setup(ratingEntity: RatingEntity) {
        titleLabel.text = ratingEntity.name
        ratingLabel.text = String(ratingEntity.rating)
    }
    
    override var reuseIdentifier: String? {
        return SearchArticleTableViewCell.cellId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
