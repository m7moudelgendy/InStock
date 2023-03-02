//
//  BrandDetailsVC.swift
//  InStock
//
//  Created by Rezk on 02/03/2023.
//

import UIKit

class BrandDetailsVC: UIViewController {
    
    let search = UISearchController()
    
    
    @IBOutlet weak var brandDetailsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       title = "Search"
        navigationItem.searchController = search

    
    }
    


}
extension BrandDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandDetailsCell", for: indexPath) as! BrandDetailsCell
        
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
    
}
