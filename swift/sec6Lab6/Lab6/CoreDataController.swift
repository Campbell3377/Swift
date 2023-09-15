//
//  CoreDataController.swift
//  Lab6
//
//  Created by Sean Campbell on 3/28/23.
//
import UIKit
import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var CityData:[City] = [City]()
    
    // Handler to persistent object container
    let persistentContainer:NSPersistentContainer
    

    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "Lab6")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        CityData = getCities()
        
    }
    
    // Add new entries into the Language Entity
    func saveCity(name: String, pic: UIImage, desc: String)
    {
        let city = City(context: persistentContainer.viewContext)
        city.name = name
        city.picture = pic.jpegData(compressionQuality: 0.75)
        city.desc = desc
//        city.id = UUID()
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            CityData = getCities()
        } catch{
            print("failed to save \(error)")
        }
    }
    
    // Delete entries from the Language Entity
    func deleteCity(city: City)
    {
        persistentContainer.viewContext.delete(city)
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            //LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    // Fetch entries from the Language Entity
    func getCities() -> [City]
    {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
}
    
