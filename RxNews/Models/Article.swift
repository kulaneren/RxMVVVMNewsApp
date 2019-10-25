//
//  Article.swift
//  RxNews
//
//  Created by eren kulan on 25/10/2019.
//  Copyright © 2019 eren kulan. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    var title: String
    var description: String?
}
