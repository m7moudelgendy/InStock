//
//  CouponCollectionViewCell.swift
//  InStock
//
//  Created by ElGendy on 01/03/2023.
//

import UIKit

class CouponCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var couponImage: UIImageView!
    
    func setCell(photo : UIImage){
        couponImage.image = photo
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSizeMake(6, 6)
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
    }
}
