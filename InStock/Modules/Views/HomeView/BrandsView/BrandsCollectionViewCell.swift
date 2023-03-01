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
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSizeMake(6, 6)
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
        self.contentView.layer.masksToBounds = true
        let url = URL(string: brand.image!.src!)
                brandImage.kf.indicatorType = .activity
                brandImage.kf.setImage(with: url)
    }
}
