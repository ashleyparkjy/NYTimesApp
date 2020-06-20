//
//  ModalViewController.swift
//  NYTimes
//
//  Created by Ashley Park on 5/14/20.
//  Copyright © 2020 Ashley Park. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    var tableView: UITableView!
    var news: News!
    var newsHeadline: String!
    var newsSnippet: String!
    var newsUrl: String!
    var newsImageUrl: String!
    
    var backButton: UIButton!
    var headlineLabel: UILabel!
    var snippetLabel: UILabel!
    var urlLabel: UILabel!
    var imageView: UIImageView!
    

    init(tableView: UITableView, news: News) {
        super.init(nibName: nil, bundle: nil)
    
        self.tableView = tableView
        self.news = news
        self.newsHeadline = news.headline.main
        self.newsSnippet = news.snippet
        self.newsUrl = news.web_url
        if news.multimedia.count != 0 {
            self.newsImageUrl = news.multimedia[0].url
        } else {
            self.newsImageUrl = ""
        }
        //wrap in if let ??
            //display the first image only
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 228/255, blue: 210/255, alpha: 1)
        
        headlineLabel = UILabel()
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.text = self.newsHeadline
        headlineLabel.textColor = .black
        headlineLabel.textAlignment = .center
        headlineLabel.numberOfLines = 0
        headlineLabel.font = UIFont(name: "Baskerville-BoldItalic", size: 25)
        view.addSubview(headlineLabel)
        
        snippetLabel = UILabel()
        snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        snippetLabel.text = self.newsSnippet
        snippetLabel.textColor = .black
        snippetLabel.textAlignment = .left
        snippetLabel.numberOfLines = 0
        snippetLabel.font = UIFont(name: "Baskerville", size: 18)
        view.addSubview(snippetLabel)
        
        urlLabel = UILabel()
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        //underline text
        urlLabel.attributedText = NSAttributedString(string: self.newsUrl, attributes:
        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        urlLabel.textColor = .blue
        urlLabel.textAlignment = .left
        urlLabel.numberOfLines = 0
        urlLabel.font = UIFont(name: "Baskerville", size: 18)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ModalViewController.tapFunction))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickLabel(sender:)))
        
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tap)
        view.addSubview(urlLabel)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if self.newsImageUrl != "" {getImage()}
        view.addSubview(imageView)
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back to Search", for: .normal)
        backButton.backgroundColor = UIColor(red: 242/255, green: 228/255, blue: 210/255, alpha: 1)
        backButton.setTitleColor(.systemBlue, for:.normal)
        backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(backButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let marginGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            headlineLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            snippetLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 15),
            snippetLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            snippetLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15),
            snippetLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            urlLabel.topAnchor.constraint(equalTo: snippetLabel.bottomAnchor, constant: 10),
            urlLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            urlLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15),
            urlLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func onClickLabel(sender:UITapGestureRecognizer) {
        openUrl(urlString: newsUrl)
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func getImage() {
        NetworkManager.fetchImage(imageURL: self.newsImageUrl) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
