//
//  ArticleViewModel.swift
//  RxNews
//
//  Created by eren kulan on 25/10/2019.
//  Copyright © 2019 eren kulan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    
    var articlesVM: [ArticleViewModel]
    
    init(_ articles: [Article]) {
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
}

struct ArticleViewModel {
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(self.article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(self.article.description ?? "")
    }
}
