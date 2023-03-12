//
//  CategoryCollectionViewCell.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favProduct: UIButton!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryPrice: UILabel!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productType: UILabel!
}
