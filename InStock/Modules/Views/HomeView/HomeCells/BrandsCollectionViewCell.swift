//
//  BrandsCollectionViewCell.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import UIKit
import Kingfisher



class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var brandImage: UIImageView!
    
    @IBOutlet weak var brandName: UILabel!
    
    
    func configCell(brand: Brands){
        brandName.text = brand.title
        self.layer.cornerRadius = 25
        self.contentView.layer.masksToBounds = true
        let url = URL(string: brand.image!.src!)
                brandImage.kf.indicatorType = .activity
                brandImage.kf.setImage(
                    with: url,
                    placeholder: nil ,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(3)),
                        .cacheOriginalImage
                    ],
                    progressBlock: nil
                )
        
    }
}
