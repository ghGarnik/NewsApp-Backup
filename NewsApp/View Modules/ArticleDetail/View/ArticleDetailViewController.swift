//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, AlertShowing {

    var viewModel: ArticleDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    private func setupBindings() {
        viewModel?.articleDetail.bind({ [weak self] articleDetail in
            guard let self = self,
            let articleDetail = articleDetail else {
                return
            }
            self.configureArticle(articleDetail)
        })
    }
    
    private func configureArticle(_ articleDetail: ArticleDetail) {
        
    }
}
