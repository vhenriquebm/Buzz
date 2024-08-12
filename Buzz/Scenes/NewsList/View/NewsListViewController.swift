//
//  ViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 10/08/24.
//

import UIKit

class NewsListViewController: UIViewController {
    private let interactor = NewsListInteractor()
    
    private lazy var newsListTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
       return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        interactor.loadNews(request: NewsListModel.FetchNews.Request())
        
        addSubviews()
        setupConstraints()
        
    }
    
    private func addSubviews() {
        self.view.addSubview(newsListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            newsListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            newsListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newsListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
}

extension NewsListViewController: UITableViewDelegate {}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Noticia"
        return cell
    }
}
