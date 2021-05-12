//
//  Article.swift
//  TopNewsApp
//
//  Created by Akshay Nandane on 12/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation


struct Article: Decodable {
    let title: String
    let description: String
}

struct articleData: Decodable {
    let articles: [Article]
}
