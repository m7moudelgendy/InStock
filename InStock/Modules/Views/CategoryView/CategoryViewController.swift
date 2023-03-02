//
//  CategoryViewController.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import UIKit

class CategoryViewController: UIViewController  {
    
    

    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
   
    
}

extension CategoryViewController : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    
    
}
