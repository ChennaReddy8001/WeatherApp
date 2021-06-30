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
    
    var selectedLocations  = [LocationObject]()
    private let writeContext = AppDelegate.shared.persistentContainer.viewContext
    
    func removeLocationAtIndex(at indexPath: IndexPath, with completionHandler: () -> Void ) {
        let location = selectedLocations[indexPath.row]
        removeSelectedLocation(location: location)
        selectedLocations.remove(at: indexPath.row)
        completionHandler()
    }

    //MARK:- core data methods
    func removeAllLocations() {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LocationObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try writeContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeSelectedLocation(location : LocationObject) {
        
        let predicate = NSPredicate(format: "locationAddress == %@", location.locationAddress!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        fetchRequest.predicate = predicate
        do {
            guard let fetchedEntities = try! writeContext.fetch(fetchRequest) as? [LocationObject] else { return }
            for sequence in fetchedEntities
            {
                writeContext.delete(sequence)
            }
            do {
                try  writeContext.save()
            }catch {
                print("err")
            }
        }
    }
    
    func getAllLocations(completionHandler: @escaping () -> Void) {

        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        
        do {
            let result = try writeContext.fetch(fetchData) as! [LocationObject]
            selectedLocations.removeAll()
            for location in result {
                selectedLocations.append(location)
            }
            completionHandler()
        }catch {
            completionHandler()
        }
    }
    
    func addNewLocation(location : Location) {
        
        guard let locaitionObjectEntity = NSEntityDescription.entity(forEntityName: "LocationObject", in: writeContext) else {return}
        
        guard  let locationEntity = NSManagedObject(entity: locaitionObjectEntity, insertInto: writeContext) as? LocationObject else { return }
        
        locationEntity.locationName = location.name
        locationEntity.locationAddress = location.address
        locationEntity.locationLatitude = location.latitude
        locationEntity.locationLongitude = location.longitude
        locationEntity.locationAddedDate = Date()
        
        do{
            try writeContext.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationAdded"), object: nil, userInfo: nil)
            
        }catch let error as NSError {
            print("could not save . \(error), \(error.userInfo)")
        }
    }
    
    func getWriteContext() -> NSManagedObjectContext {
        let appDelegate = AppDelegate.shared
        let manageContent = appDelegate.persistentContainer.viewContext
        return manageContent
    }
}
