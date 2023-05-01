//
//  DataControllerDB.swift
//  App-movilidad
//
//  Created by iOS Lab on 30/04/23.
//

import Foundation
import CoreData

class DataControllerDB: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "App_Base")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataControllerUsers \(error.localizedDescription)")
                
                guard let url = description.url else { return }
                
                do {
                    try self.container.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: description.type, options: description.options)
                    try self.container.persistentStoreCoordinator.addPersistentStore(ofType: description.type, configurationName: nil, at: url, options: description.options)
                } catch {
                    fatalError("Failed to delete and recreate store: \(error)")
                }
            }
        }
    }
    
    func save(context: NSManagedObjectContext) -> Bool? {
        do {
            try context.save()
            print("Data saved successfully.")
            return true
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            return false
            //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
        }
        
        
    }
    
    func addUser(name: String, age: Int32, gender: String, email: String, cell_phone: String, t_car: Bool, t_motorcycle: Bool, t_scooter: Bool, t_bicycle: Bool, t_walking: Bool, preferred_location: String, password : String,  context: NSManagedObjectContext) -> Bool? {
        let user = Users(context: context)
        user.id = UUID()
        user.name = name
        user.age = age
        user.gender = gender
        user.email = email
        user.cell_phone = cell_phone
        user.t_car = t_car
        user.t_motorcycle = t_motorcycle
        user.t_scooter = t_scooter
        user.t_bicycle = t_bicycle
        user.t_walking = t_walking
        user.preferred_location = preferred_location
        user.password = password
        
        if let resp = save(context: context){
            return true
        }
        
        return false
        
    }
    
    func editUsers(user: Users, name: String, age: Int32, gender: String, email: String, cell_phone: String, t_car: Bool, t_motorcycle: Bool, t_scooter: Bool, t_bicycle: Bool, t_walking: Bool, preferred_location: String, password : String,  context: NSManagedObjectContext) -> Bool? {
        user.name = name
        user.age = age
        user.gender = gender
        user.email = email
        user.cell_phone = cell_phone
        user.t_car = t_car
        user.t_motorcycle = t_motorcycle
        user.t_scooter = t_scooter
        user.t_bicycle = t_bicycle
        user.t_walking = t_walking
        user.preferred_location = preferred_location
        user.password = password
                
        if let resp = save(context: context){
            return true
        }
        
        return false
    }
    
    func loadUser(id: UUID, context: NSManagedObjectContext) -> Users?{
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
         
        do {
            let record = try context.fetch(fetchRequest)
            if let item = record.first {
                return item
            } else {
                print("User does not exist id: \(id)")
                return nil
            }
        } catch let error as NSError {
            print("Could not read record. \(error), \(error.userInfo)")
            return nil
        }

    }
    
    func loadUserByEmailPassword(email: String, password: String, context: NSManagedObjectContext) -> Users?{
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email as CVarArg, password as CVarArg)
         
        do {
            let record = try context.fetch(fetchRequest)
            if let item = record.first {
                return item
            } else {
                print("User does not exist")
                return nil
            }
        } catch let error as NSError {
            print("Could not read record. \(error), \(error.userInfo)")
            return nil
        }

    }
}
