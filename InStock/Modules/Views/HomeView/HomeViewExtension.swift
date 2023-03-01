//
//  HomeViewExtension.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import UIKit

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == BrandsCollectionView {
            return viewModel.result.count
        }
        return viewModel.couponArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == BrandsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath) as! BrandsCollectionViewCell
            cell.configCell(brand: viewModel.result[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "couponsCell", for: indexPath) as! CouponCollectionViewCell
        cell.setCell(photo: viewModel.couponArr[indexPath.row].photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == BrandsCollectionView {
            return CGSize(width: 181, height: 181)
        }
        return CGSize(width: couponCollectionView.frame.width, height: couponCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == couponCollectionView{
                UIPasteboard.general.string = viewModel.couponArr[indexPath.row].title
                print(UIPasteboard.general.string!)
            }
        }
}

