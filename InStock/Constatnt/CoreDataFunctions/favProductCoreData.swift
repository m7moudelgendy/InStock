//
//  facouriteProductCoreDate.swift
//  InStock
//
//  Created by Hader on 9/3/23.
//

import Foundation
import CoreData
import UIKit

protocol ProCoreDataProtocol {
    static func SaveProToCoreData(proName : String , proPrice : String ,proLink : String ) ->()
    static func FetchProFromCoreData() -> [NSManagedObject]
    static func DeleteProFromCoreData (index : Int) ->()
    static func DeleteAllWishlistFromCoreData () ->()

}

class ProductCoreDataManager : ProCoreDataProtocol {
    static func DeleteAllWishlistFromCoreData() {
        var context :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        let fetchArr = ProductCoreDataManager.FetchProFromCoreData()
        if fetchArr.count != 0 {
            context?.delete(fetchArr[0])
            do {
                try context?.save()
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
            
        }
        else {
            
            return
        }
    }
    
    
    static func FetchProFromCoreData() -> [NSManagedObject] {
        var context :NSManagedObjectContext?
        var arrUser: [NSManagedObject]? = [NSManagedObject]()
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavProduct")
        arrUser = try? context?.fetch(fetchReq)
        return arrUser ?? []
    }
    
    
    
    static func SaveProToCoreData(proName : String , proPrice : String ,proLink : String ) {
        var context :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        let uEntity = NSEntityDescription.entity(forEntityName: "FavProduct", in: context!)
        let product = NSManagedObject(entity: uEntity!, insertInto: context!)   //object from Users entity in coreData
        product.setValue(proName, forKey: "proName")
        product.setValue(proPrice , forKey: "proPrice")
        product.setValue(proLink , forKey: "proLink")
        
        try? context?.save()
        
    }
    
    static func DeleteProFromCoreData(index : Int) {
        var proContext :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        proContext = appDelgate.persistentContainer.viewContext
        let fetchArr = ProductCoreDataManager.FetchProFromCoreData()
        if fetchArr.count != 0 {
            proContext?.delete(fetchArr[index])
            do {
                try proContext?.save()
                
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        else {
            return
        }
        
    }
    
    
    
    
}
