//
//  ViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 10/08/24.
//

import UIKit

protocol NewListDisplayLogic: AnyObject {
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel)
    func displayError(message: String)
}

class NewsListViewController: UIViewController {
    
    var interactor: NewsListBusinessLogic?
    var articles: [NewsListModel.FetchNews.ViewModel.DisplayedArticle] = []
    
    private lazy var newsListTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
       return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        addSubviews()
        setupConstraints()
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    
    private func getNews() {
        interactor?.loadNews(request: NewsListModel.FetchNews.Request())
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
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}

extension NewsListViewController: NewListDisplayLogic {
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel) {
        self.articles = viewModel.displayedArticles
        newsListTableView.reloadData()
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Erro!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    
}
