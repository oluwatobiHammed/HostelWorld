//
//  HWRealmManager.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import  RealmSwift
import Foundation

@MainActor
final class HWRealmManager {
    
    static let shared = HWRealmManager()
    static let SCHEMA_VERSION: UInt64 = 12
    
    lazy nonisolated var config: Realm.Configuration = {
        let config = Realm.Configuration(schemaVersion: HWRealmManager.SCHEMA_VERSION
                                         
                                         /*                                ,migrationBlock: { (migration, oldVersion) in
                                          UserDefaults.standard.removeObject(forKey: kUserDefaults.TimlineLastUpdated)
                                          AnalyticsManager.recordEvent(name: "B2B - Database Migrated")
                                          } */
                                         , deleteRealmIfMigrationNeeded: true)
        return config
    }()
    
    lazy nonisolated var realm = try? Realm(configuration: config)
    
    /**
     Deletes all objects in the Realm database.
     
     - Note: This function uses Realm's write transaction to delete all objects in the database.
     
     - SeeAlso: `realm`
     */
    func deleteDatabase() {
        do {
            try realm?.write {
                // Check if the realm instance is not invalidated before deleting all objects
                guard let realm else { return }
                
                realm.deleteAll()
            }
        } catch {
            return
        }
    }
    
    
    /**
     Deletes a Realm object.
     
     - Parameters:
     - realmObject: The Realm Object to be deleted.
     - isCascading: A boolean indicating whether to delete associated objects in a cascading manner. Default is false.
     
     - Note: This function checks if the provided Realm object is not invalidated and deletes it using Realm's write transaction.
     
     - SeeAlso: `realm`
     */
    func deleteObject(realmObject: Object) {
        guard !realmObject.isInvalidated else { return }
        do {
            try realm?.write { [weak self] in
                self?.realm?.delete(realmObject)
                
            }
        } catch {
            return
        }
    }
    
    /**
     Saves a Realm object.
     
     - Parameters:
     - realmObject: The Realm Object to be saved.
     
     - Note: This function checks if the provided Realm object is not invalidated and saves it using Realm's write transaction with the `.error` update policy.
     
     - SeeAlso: `realm`
     */
    func saveObjects(realmObject: Object) {
        guard !realmObject.isInvalidated else { return }
        do {
            try realm?.write { [weak self] in
                self?.realm?.add(realmObject, update: .error)
            }
        } catch {
            return
        }
    }
    
    
    /**
     Saves an array of Realm objects.
     
     - Parameters:
     - objects: An array of Realm objects to be saved.
     
     - Note: This function checks if any object in the array is invalidated and saves only the objects that are not invalidated using Realm's write transaction.
     
     - SeeAlso: `realm`
     */
    func saveRealmArray(_ objects: [Object]) {
        guard !objects.contains(where:  { $0.isInvalidated }) else { return }
        do {
            try realm?.write {
                // Save only the objects that are not invalidated
                let validObjects = objects.filter { !$0.isInvalidated }
                realm?.add(validObjects)
            }
        } catch {
            return
        }
    }
    
    /**
     Saves or updates an array of Realm objects.
     
     - Parameters:
     - objects: An array of Realm objects to be saved or updated.
     
     - Note: This function checks if any object in the array is invalidated and saves or updates only the objects that are not invalidated using Realm's write transaction with the `.all` update policy.
     
     - SeeAlso: `realm`
     */
    func saveOrUpdateRealmArray(_ objects: [Object]) {
        guard !objects.contains(where:  { $0.isInvalidated }) else { return }
        do {
            try realm?.write {
                // Save or update only the objects that are not invalidated
                realm?.add(objects, update: .all)
            }
        } catch {
            return
        }
    }
    
    
    /**
     Updates or saves a Realm object.
     
     - Parameters:
     - realmObject: The Realm Object to be updated or saved.
     
     - Note: This function checks if the provided Realm object is not invalidated and updates or saves it using Realm's write transaction with the `.all` update policy.
     
     - SeeAlso: `realm`
     */
    func updateOrSave(realmObject: Object) {
        guard !realmObject.isInvalidated else { return }
        do {
            try realm?.write {
                realm?.add(realmObject, update: .all)
            }
        } catch {
            return
        }
    }
    
    /**
     Updates or saves a Realm object with a completion block.
     
     - Parameters:
     - realmObject: The Realm Object to be updated or saved.
     - completion: A completion block to be executed after the update or save operation.
     
     - Note: This function checks if the provided Realm object is not invalidated and updates or saves it using Realm's write transaction with the `.all` update policy. It executes the provided completion block afterward.
     
     - SeeAlso: `realm`
     */
    func updateOrSave(realmObject: Object, completion: @escaping @MainActor () -> ()) {
        guard !realmObject.isInvalidated else { return }
        do {
            try realm?.write { [weak self] in
                self?.realm?.add(realmObject, update: .all)
                completion()
            }
        } catch {
            completion()
        }
    }
    
    
    
    /**
     Fetches all objects of a specified type.
     
     - Parameters:
     - type: The type of the Realm Object to fetch.
     
     - Returns: An optional Results<Object> representing all objects of the specified type. Returns nil if the fetched result is invalid or empty.
     
     - Note: This function fetches all objects of the specified type.
     
     - SeeAlso: `realm`
     */
    func fetchObjects(type: Object.Type) -> Results<Object>? {
        return realm?.objects(type)
    }
    
    /**
     Fetches objects of a specified type sorted by a key path.
     
     - Parameters:
     - type: The type of the Realm Object to fetch.
     - keyPath: The key path by which to sort the objects.
     - ascending: A boolean indicating the sorting order (ascending or descending).
     
     - Returns: An optional Results<Object> representing objects of the specified type sorted by the provided key path. Returns nil if the fetched result is invalid or empty.
     
     - Note: This function fetches objects of the specified type and sorts them based on the provided key path and sorting order.
     
     - SeeAlso: `realm`
     */
    func fetchObjects(type: Object.Type, sortedByKeyPath keyPath: String, isAscending ascending: Bool) -> Results<Object>? {
        return realm?.objects(type).sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    
    
    /**
     Clears all objects of a specified type.

     - Parameters:
       - type: The type of the Realm Object to clear.

     - Note: This function fetches all objects of the specified type, checks for validity, and deletes only the objects that are not invalidated.

     - SeeAlso: `realm`
     */
    func clearObject(type: Object.Type) {
        if let results = realm?.objects(type.self) {
            // Check if the results array is not empty and not invalidated
            guard !results.isEmpty, !results.contains(where: { $0.isInvalidated }) else { return }

            guard !results.isInvalidated || results.first != nil else { return }
            do {
                try realm?.write { [weak self] in
                    // Delete only the objects that are not invalidated
                    let validObjects = results.filter { !$0.isInvalidated }
                    self?.realm?.delete(validObjects)
                }
            } catch {
                return
            }
        }
    }
    
    
}


extension HWRealmManager {
    
    /**
     Retrieves the CityProperties object representing the city Propertiese.
     
     - Returns: An optional CityProperties object representing the  city Properties. Returns nil if the fetched result is invalid or empty.
     
     - Note: This property fetches CityProperties objects and ensures that th e returned data is valid and not invalidated.
     
     - SeeAlso: `fetchObjects(type:)`
     */
    var cityProperties: CityProperties? {
        let results = fetchObjects(type: CityProperties.self)
        if let results, !results.contains(where: { $0.isInvalidated }),  !results.isEmpty {
            return results.first as? CityProperties
        }
        return nil
    }
    
    
    func fetchProperty(forID propertyID: String) -> SingleProperty? {


           let propertyPredicate = NSPredicate(format: "id == %@", propertyID)

        if let result = fetchObject(type: SingleProperty.self, withPredicate: propertyPredicate) as? SingleProperty, !result.isInvalidated {
            return result
        }
        return nil
    }
    
    
    /**
     Fetches a single object of a specified type with an optional predicate.

     - Parameters:
       - type: The type of the Realm Object to fetch.
       - predicate: An optional NSPredicate to filter the object.

     - Returns: An optional Realm Object of the specified type. Returns nil if the fetched result is invalid or not found.

     - Note: This function fetches a single object of the specified type based on the provided predicate if available. If no predicate is provided, it returns the first object of the specified type.

     - SeeAlso: `realm`
     */
    func fetchObject(type: Object.Type, withPredicate predicate: NSPredicate? = nil) -> Object? {
        if let predicate {
            return realm?.objects(type).filter(predicate).first
        } else {
            return realm?.objects(type).first
        }
    }
}
