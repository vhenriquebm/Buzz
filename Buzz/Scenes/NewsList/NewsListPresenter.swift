//
//  NewsListPresenter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 12/08/24.
//

import Foundation

protocol NewsListPresentationLogic {
    func presentFetchedNews(response: NewsListModel.FetchNews.Response)
    func presentError(error: Error)
}

class NewsListPresenter: NewsListPresentationLogic {
    
    weak var viewController: NewListDisplayLogic?
    
    func presentFetchedNews(response: NewsListModel.FetchNews.Response) {
        let displayedArticles = response.articles.map { article in
            return NewsListModel.FetchNews.ViewModel.DisplayedArticle(title: article.title,
                                                                      description: article.description,
                                                                      author: article.author,
                                                                      publishedAt: formatDate(article.publishedAt),
                                                                      imageUrl: article.urlToImage)
        }
        
        let viewModel = NewsListModel.FetchNews.ViewModel(displayedArticles: displayedArticles)
        
        viewController?.displayFetchedNews(viewModel: viewModel)
    }
    
    func presentError(error: any Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MM 'de' yyyy"
        return formatter.string(from: date)
    }
    
}
