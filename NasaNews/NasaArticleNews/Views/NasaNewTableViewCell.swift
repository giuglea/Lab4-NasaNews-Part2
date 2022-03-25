//
//  NasaNewTableViewCell.swift
//  NasaNews
//
//  Created by Tzy on 18.03.2022.
//

import UIKit
import SDWebImage

final class NasaNewTableViewCell: UITableViewCell {
    static let cellId = "NasaNewTableViewCell"
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let accesrroyImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setUp(with model: Item) {
        titleLabel.text = model.title
        dateLabel.text = model.date
        let url = URL(string: model.itemName)
        accesrroyImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    override var reuseIdentifier: String? {
        return NasaNewTableViewCell.cellId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NasaNewTableViewCell {
    func configure() {
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 2
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.numberOfLines = 1
        
        dateLabel.textColor = UIColor.secondaryLabel
        accesrroyImageView.tintColor = UIColor.secondaryLabel
        accesrroyImageView.contentMode = .scaleAspectFit
        accesrroyImageView.image = UIImage(systemName: "arrowtriangle.right")
        accesrroyImageView.clipsToBounds = true
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(accesrroyImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        accesrroyImageView.translatesAutoresizingMaskIntoConstraints = false
        accesrroyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        accesrroyImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10).isActive = true
        accesrroyImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        accesrroyImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        accesrroyImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        accesrroyImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
