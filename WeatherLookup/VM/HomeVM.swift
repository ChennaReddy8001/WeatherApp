//
//  HomeVM.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import Foundation
import UIKit
import CoreData

class HomeVM {
    
    var selctedLocations  = [LocationObject]()
    
    func removeAllLocationsFromCoreData() {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LocationObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    func removeLocationFromCoreData(location : LocationObject) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let predicate = NSPredicate(format: "locationAddress == %@", location.locationAddress!)
        var fetchedEntities = [LocationObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        fetchRequest.predicate = predicate
        do {
            fetchedEntities = try! managedContext.fetch(fetchRequest) as! [LocationObject]
            for sequence in fetchedEntities
            {
                managedContext.delete(sequence)
            }
            do {
                try  managedContext.save()
            }catch {
                print("err")
            }
        }
    }
    
    func getAllLocations() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        
        do {
            let result = try manageContent.fetch(fetchData) as! [LocationObject]
            print(result)
            selctedLocations.removeAll()
            for location in result {
                selctedLocations.append(location)
            }
            print(selctedLocations)
        }catch {
            print("err")
        }
    }
    
    func addNewLocation(location : Location) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let manageContent = appDelegate.persistentContainer.viewContext
        
        guard let locaitionObjectEntity = NSEntityDescription.entity(forEntityName: "LocationObject", in: manageContent) else {return}
        
        guard  let locationEntity = NSManagedObject(entity: locaitionObjectEntity, insertInto: manageContent) as? LocationObject else { return }
        
        locationEntity.locationName = location.name
        locationEntity.locationAddress = location.address
        locationEntity.locationLatitude = location.latitude
        locationEntity.locationLongitude = location.longitude
        locationEntity.locationAddedDate = Date()
        
        do{
            try manageContent.save()
            getAllLocations()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationAdded"), object: nil, userInfo: nil)
            
            
        }catch let error as NSError {
            
            print("could not save . \(error), \(error.userInfo)")
        }
        
    }
    
}
