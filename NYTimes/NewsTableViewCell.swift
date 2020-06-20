//
//  NewsTableViewCell.swift
//  NYTimes
//
//  Created by Ashley Park on 5/10/20.
//  Copyright © 2020 Ashley Park. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Baskerville-SemiBold", size: 18)
        titleLabel.numberOfLines = 0 //make label multi-line
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel = UILabel()
        dateLabel.textColor = UIColor.lightGray
        dateLabel.font = UIFont(name: "Baskerville-SemiBold", size: 15)
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        setupConstraints()
    }
    
    func setupConstraints() {
        //recommended padding utilized
        let marginGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            ])
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            ])
    }
    
    func configure(for news: News) {
        //set all text in images accordingly
        titleLabel.text = news.headline.main
        if let index = news.pub_date.firstIndex(of: "T") {
            let substring = news.pub_date[..<index]
            let date = String(substring)
            dateLabel.text = date
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
