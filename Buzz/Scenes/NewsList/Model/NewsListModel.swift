//
//  NewsListModel.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 12/08/24.
//

import Foundation

struct NewsListModel {
    struct Request {}
    struct Response {
        let articles:[Article]
    }
    
    struct ViewModel {
        struct DisplayedArticle {
            let title: String
            let description: String
            let author: String
            let publishedAt: String
            let imageUrl: URL
        }
        
        let displayedArticles: [DisplayedArticle]
    }
}
