//
//  FavouriteButton.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit



final class FavouriteButton: TouchableView {
        
    var isFavourite: Bool? {
        didSet {
            guard let isFavourite = isFavourite else { return }
            let state: FavouriteButtonState = isFavourite ? .buttonOn : .buttonOff
            
            changeImage(forState: state)
            if let completion = completion {
                completion(isFavourite)
            }
        }
    }
    
    var completion: TypedAction<Bool>?

    @IBOutlet private weak var buttonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        loadNibForUIView()
        configureView()
    }
}

extension FavouriteButton {
    private func configureView() {
        backgroundColor = .clear
        changeImage(forState: .buttonOff)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
        self.addGestureRecognizer(tapRecognizer)
    }
}

extension FavouriteButton {
    @objc func didTapOnView() {
        guard let isFavourite = isFavourite else { return }
        self.isFavourite = !isFavourite
    }
}

extension FavouriteButton {
    private func changeImage(forState state: FavouriteButtonState ) {
        let favouriteImageName = state.imageName
        
        guard let favouriteImage = UIImage(named: favouriteImageName)?.withRenderingMode(.alwaysOriginal) else { return }
        buttonImage.image = favouriteImage
    }
}
