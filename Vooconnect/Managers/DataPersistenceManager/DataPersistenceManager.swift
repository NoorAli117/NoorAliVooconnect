//
//  DataPersistenceManager.swift
//  Vooconnect
//
//  Created by Online Developer on 01/04/2023.
//

import UIKit
import CoreData

class DataPersistenceManager{
    
    enum DatabaseError: Error{
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func saveUserProfile(model: UserDetail, jwt: String, completion: @escaping (Result<Void, Error>)->()){
        guard let appDelegate = AppDelegate.shared else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = UserProfileItem(context: context)
        
        item.full_name = ((model.firstName ?? "") + " " + (model.lastName ?? ""))
        item.jwt = jwt
        item.uuid = model.uuid
        item.username = model.username
        item.profile_image = model.profileImage
        
        do{
            try context.save()
            logger.error("Successfully Save User Profile Data", category: .coreData)
            completion(.success(()))
        }catch{
            logger.error("Error Failed To Save Data: \(error.localizedDescription)", category: .coreData)
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func getUserProfiles(completion: @escaping (Result<[UserProfileItem], Error>)->()){
        guard let appDelegate = AppDelegate.shared else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<UserProfileItem>
        
        request = UserProfileItem.fetchRequest()
        
        do{
            let profiles = try context.fetch(request)
            logger.error("Successfully Retrieve User Profiles", category: .coreData)
            completion(.success(profiles))
        }catch{
            logger.error("Error Failed To Fetch: \(error.localizedDescription)", category: .coreData)
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteAllProfiles() {
        guard let appDelegate = AppDelegate.shared else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<UserProfileItem>
        request = UserProfileItem.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as NSManagedObject
                context.delete(managedObjectData)
            }
            logger.error("Successfully Deleted User Profiles.", category: .coreData)
        } catch{
            logger.error("Error Deleting UserProfileItem Entity: \(error.localizedDescription)", category: .coreData)
        }
    }
    
    func updateProfile(model: UserDetail, uuid: String, jwt: String){
        guard let appDelegate = AppDelegate.shared else { return }
        
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<UserProfileItem> = UserProfileItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)

        do {
            let results = try context.fetch(fetchRequest)
            if let item = results.first {
                item.full_name = ((model.firstName ?? "") + " " + (model.lastName ?? ""))
                item.uuid = model.uuid
                item.username = model.username
                item.profile_image = model.profileImage
                
                try context.save()
            }else{
                saveUserProfile(model: model, jwt: jwt) { _ in }
            }
        } catch let error as NSError {
            logger.error("Error Updating UserProfileItem Entity: \(error.localizedDescription)", category: .coreData)
        }
    }
}
