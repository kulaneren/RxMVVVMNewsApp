//
//  NewsTableViewController.swift
//  RxNews
//
//  Created by eren kulan on 25/10/2019.
//  Copyright © 2019 eren kulan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.populateNews()
    }
    
    private func populateNews() {
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=gb&apiKey=674ba098a8054b8fb25c4ba85d62ee04")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                self.articleListVM = ArticleListViewModel(articleResponse.articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    //MARK: TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellIdentifier", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell is not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.lblTitle.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
        .drive(cell.lblDescription.rx.text)
        .disposed(by: disposeBag)
        
        return cell
    }
}
