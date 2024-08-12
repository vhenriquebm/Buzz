//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 12/08/24.
//

import Foundation

class NewsListInteractor {
    private var worker: NewsApiWorker
    private var articles = [Article]()
    
    init(worker: NewsApiWorker = NewsApiWorker(service: URLSessionNetworking())) {
        self.worker = worker
    }
    
    func loadNews() {
        worker.getNews { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    print (error)
                }
            }
        }
    }
}
