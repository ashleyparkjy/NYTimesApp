//
//  ViewController.swift
//  NYTimes
//
//  Created by Ashley Park on 5/10/20.
//  Copyright © 2020 Ashley Park. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    //view vars
    var tableView = UITableView()
    
    let newsCellIdentifier = "NewsCell"
    var searchController: UISearchController!
    
    //model var
    var newsArray: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "New York Times News"
        view.backgroundColor = .brown
    
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: newsCellIdentifier)
        tableView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by keywords"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                let keywordsArray = searchText.components(separatedBy: " ")
                NetworkManager.getNews(fromKeyword: keywordsArray) { (news) in
                    self.newsArray = news
                    print("got news")
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                print("search by keywords")
            }
            else {
                self.newsArray = []
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    //numberOfRowsInSection is the identifier of the function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if section == 0: , etc. if more than one section
        return newsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .default
        //.none makes it double click, .default highlights color
        cell.configure(for: newsArray[indexPath.row])
//        cell.titleLabel.text = news.headline.main
//        cell.dateLabel.text = news.pub_date
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension;
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    //heightForRowAt set in func viewDidLoad() - dynamic height
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArray[indexPath.row]
        //pop up
        let vc = ModalViewController(tableView: tableView, news: news)
        //check in console
//        print("selected: \(song.songName)")
        present(vc, animated: true, completion: nil)
//        cell.selectionStyle = .default
    }
}
