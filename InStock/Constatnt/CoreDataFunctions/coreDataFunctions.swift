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
    static func SaveToCoreData(firstName : String , lastName : String , email : String ) ->()
    static func FetchFromCoreData() -> [NSManagedObject]
    
}

class CoreDataManager : CoreDataProtocol {
    static func FetchFromCoreData() -> [NSManagedObject] {
        var context :NSManagedObjectContext?
        var arrUser: [NSManagedObject]? = [NSManagedObject]()
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Users")
        arrUser = try? context?.fetch(fetchReq)
        
        print("data fetch")
        return arrUser ?? []
    }
    
    
    
    static func SaveToCoreData(firstName: String, lastName: String, email: String) {
        var context :NSManagedObjectContext?
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        context = appDelgate.persistentContainer.viewContext
        let uEntity = NSEntityDescription.entity(forEntityName: "Users", in: context!)
        let user = NSManagedObject(entity: uEntity!, insertInto: context!)   //object from Users entity in coreData
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName , forKey: "lastName")
        user.setValue(email , forKey: "email")
        
        try? context?.save()
        print("user saved in core Data")
        
    }
    
    
    
    
}
