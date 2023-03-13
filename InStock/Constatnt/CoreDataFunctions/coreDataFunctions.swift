//
//  coreDataFunctions.swift
//  InStock
//
//  Created by Hader on 5/3/23.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataProtocol {
    static func SaveToCoreData(firstName : String , lastName : String , email : String , id : Int) ->()
    static func FetchFromCoreData() -> [NSManagedObject]
    static func DeleteFromCoreData () ->()
    
}

class CoreDataManager : CoreDataProtocol {
    
    static func FetchFromCoreData() -> [NSManagedObject] {
        var context :NSManagedObjectContext?
        var arrUser: [NSManagedObject]? = [NSManagedObject]()
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Users")
        arrUser = try? context?.fetch(fetchReq)
        
        return arrUser ?? []
    }
    
    
    
    static func SaveToCoreData(firstName: String, lastName: String, email: String, id : Int) {
        var context :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        let uEntity = NSEntityDescription.entity(forEntityName: "Users", in: context!)
        let user = NSManagedObject(entity: uEntity!, insertInto: context!)   //object from Users entity in coreData
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName , forKey: "lastName")
        user.setValue(email , forKey: "email")
        user.setValue(id , forKey: "id")
        
        try? context?.save()
        
    }
    
    static func DeleteFromCoreData() {
        var context :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
         let fetchArr = CoreDataManager.FetchFromCoreData()
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
    
    
    
    
}
