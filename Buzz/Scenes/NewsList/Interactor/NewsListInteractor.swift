//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 12/08/24.
//

import Foundation

protocol NewsListBusinessLogic {
    func loadNews(request: NewsListModel.FetchNews.Request)
}

protocol NewsListDataStore {
    var articles: [Article] { get set }
}

class NewsListInteractor: NewsListBusinessLogic, NewsListDataStore {
    private var worker: NewsApiWorker
    var articles = [Article]()
    var presenter: NewsListPresentationLogic?
    
    
    init(worker: NewsApiWorker = NewsApiWorker(service: URLSessionNetworking())) {
        self.worker = worker
    }
    
    func loadNews(request: NewsListModel.FetchNews.Request) {
        worker.getNews { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles
                    let response = NewsListModel.FetchNews.Response(articles: articles)
                    self.presenter?.presentFetchedNews(response: response)
                case .failure(let error):
                    print (error)
                    self.presenter?.presentError(error: error)
                }
            }
        }
    }
}
