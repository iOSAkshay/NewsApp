//
//  URLRequest+Extensions.swift
//  TopNewsApp
//
//  Created by Akshay Nandane on 12/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct  Resources<T: Decodable> {
    let url: URL
}

extension URLRequest{
    
    static func load<T>(resource: Resources<T>) -> Observable<T?> {
        
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map {data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
