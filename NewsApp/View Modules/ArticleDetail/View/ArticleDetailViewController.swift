//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController, AlertShowing {
    
    @IBOutlet private weak var headImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    

    var viewModel: ArticleDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupBindings()
        viewModel?.viewDidLoad()
    }
}

//MARK: - Configure View

extension ArticleDetailViewController {
    private func configureView() {
        resetCopies()
        applyStyles()
    }
    
    private func resetCopies() {
        titleLabel.text = nil
        authorLabel.text = nil
        contentLabel.text = nil
    }
    
    private func applyStyles() {
        titleLabel.applyStyle(.title)
        authorLabel.applyStyle(.date)
        contentLabel.applyStyle(.body)
    }
}

//MARK: - Binding ViewModel

extension ArticleDetailViewController {
    private func setupBindings() {
        viewModel?.articleDetail.bind({ [weak self] articleDetail in
            guard let self = self,
            let articleDetail = articleDetail else {
                return
            }
            self.fillContent(articleDetail)
        })
    }
    
    private func fillContent(_ articleDetail: ArticleDetail) {
        if let imageURL = URL(string: articleDetail.imageUrl) {
            headImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "articlePlaceholder"))
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = articleDetail.title
            self.authorLabel.text = articleDetail.author.appending(" - \(articleDetail.date)")
            self.contentLabel.text = articleDetail.content
        }
    }
}
