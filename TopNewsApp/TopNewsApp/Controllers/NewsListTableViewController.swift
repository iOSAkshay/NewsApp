//
//  NewsListTableViewController.swift
//  TopNewsApp
//
//  Created by Akshay Nandane on 12/05/21.
//  Copyright © 2021 com.app.connectme. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsListTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Fatal error")
        }
        cell.titleLable.text = self.articles[indexPath.row].title
        cell.descriptionLable.text = self.articles[indexPath.row].description
        
        return cell
    }
    
    //
    private func populateNews(){
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ad0f88d4d9b54862b240ce5eace0549d")!
        let resource = Resources<articleData>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { result in
                if let result = result {
                    self.articles = result.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    /*
     
     //
     private func populateNews(){
         
         let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ad0f88d4d9b54862b240ce5eace0549d")!
         Observable.just(url)
             .flatMap { url -> Observable<Data> in
                 let request = URLRequest(url: url)
                 return URLSession.shared.rx.data(request: request)
         } .map {data -> [Article]? in
             return try? JSONDecoder().decode(articleData.self, from: data).articles
         }.subscribe(onNext: {[weak self] articles in
             if let articles = articles{
                 self?.articles = articles
                 DispatchQueue.main.async {
                     self?.tableView.reloadData()
                 }
             }
         }).disposed(by: disposeBag)
     }
     
     */
    
}
