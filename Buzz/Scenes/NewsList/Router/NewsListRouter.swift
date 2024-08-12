//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 10/08/24.
//

import UIKit

class NewsListRouter {
    static func createInitialViewController() -> UIViewController {
        let controller = NewsListViewController()
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
}
