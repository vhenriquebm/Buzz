//
//  NewsApiWorker.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 12/08/24.
//

import Foundation

enum NewsApi {
    static let baseUrl = "https://my-json-server.typicode.com/alura-cursos/news-api/"
    static let articles = "articles"
}

class NewsApiWorker {
    private let service: NetworkingService
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: NewsApi.baseUrl + NewsApi.articles) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        service.request(url: url) { (result: Result<[Article], Error>) in

            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
