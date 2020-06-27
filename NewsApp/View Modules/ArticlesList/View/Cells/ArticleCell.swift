//
//  ArticleCell.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit
import Kingfisher

final class ArticleCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var thumbnail: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var body: UILabel!
    @IBOutlet private weak var cellSeparator: UIView!
    
    private var thumbnailURL: String? {
        didSet {
            guard let url = URL(string: thumbnailURL ?? "") else {
                return thumbnail.image = nil
                
            }
            thumbnail.kf.setImage(with: url)
            thumbnail.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "thumbnailPlaceholder"))
        }
    }
    
    //MARK: -  Initial configuration
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        applyStyles()
    }
    
    override func prepareForReuse() {
        thumbnailURL = nil
        dateLabel.text = nil
        title.text = nil
        body.text = nil
    }
    
    //MARK: - Configure Cell
    
    /// Sets cell content.
    /// - Parameter model: cell content model.
    func configureCell(_ model: CompactArticle) {
        dateLabel.text = model.date
        title.text = model.title
        body.text = model.summary
        thumbnailURL = model.thumbnailURL
    }
    
    //MARK: - Style
    
    private func applyStyles() {
        dateLabel.applyStyle(.date)
        title.applyStyle(.title)
        body.applyStyle(.body)
        
        cellSeparator.backgroundColor = .black
        cellSeparator.alpha = 0.3
        
        thumbnail.roundCodners()
    }
}
