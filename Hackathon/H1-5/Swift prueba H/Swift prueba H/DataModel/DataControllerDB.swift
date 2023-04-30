//
//  DataControllerDB.swift
//  Swift prueba H
//
//  Created by Octavio Perez on 30/04/23.
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
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully.")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addUser(name: String, age: Int32, gender: String, email: String, cell_phone: String, t_car: Bool, t_motorcycle: Bool, t_scooter: Bool, t_bicycle: Bool, t_walking: Bool, preferred_location: Int32, password : String,  context: NSManagedObjectContext) {
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
        
        save(context: context)
    }
    
    func editUsers(user: Users, name: String, age: Int32, gender: String, email: String, cell_phone: String, t_car: Bool, t_motorcycle: Bool, t_scooter: Bool, t_bicycle: Bool, t_walking: Bool, preferred_location: Int32, password : String,  context: NSManagedObjectContext) {
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
                
        save(context: context)
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
}
