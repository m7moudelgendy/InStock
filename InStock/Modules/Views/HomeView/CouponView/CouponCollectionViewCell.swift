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
     
    }
}
