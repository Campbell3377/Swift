//
//  coreDataController.swift
//  tableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 3/7/23.
//  CoreData management module

import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var LanData:[Language] = [Language]()
    @Published var OSData:[OS] = [OS]()
    @Published var MoData:[Mobile] = [Mobile]()
    
    // Handler to persistent object container
    let persistentContainer:NSPersistentContainer
    
    /* constructor initializes the persistentContainer and load data to the three lists
       
     LanData : Programming Language Objects in Language Entity
     OSData  : Operating System objects in OS Entity
     MoData  : Mobile System objescts in the Mobile Entity
       
     */
    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "tableData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        LanData = getLanguages()
        OSData = getOS()
        MoData = getMobile()
        
    }
    
    // Add new entries into the Language Entity
    func saveLanguage(lanNam: String)
    {
        let lan = Language(context: persistentContainer.viewContext)
        lan.name = lanNam
        lan.id = UUID()
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
    }
    
    // Delete entries from the Language Entity
    func deleteLanguage(lan: Language)
    {
        persistentContainer.viewContext.delete(lan)
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            //LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    // Fetch entries from the Language Entity
    func getLanguages() -> [Language]
    {
        let fetchRequest: NSFetchRequest<Language> = Language.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
    
    
    // Insert entries into the OS Entity
    func saveOS(lanNam: String)
    {
        let os = OS(context: persistentContainer.viewContext)
        os.name = lanNam
        os.id = UUID()
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            OSData = getOS()
        } catch{
            print("failed to save \(error)")
        }
    }
    
    // Fetch entries from the OS Entity
    func getOS() -> [OS]
    {
        let fetchRequest: NSFetchRequest<OS> = OS.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
    
    // Delete entries from the OS Entity
    func deleteOs(operatingS: OS)
    {
        persistentContainer.viewContext.delete(operatingS)
        do {
            //print("saving")
            try persistentContainer.viewContext.save()
            //LanData = getLanguages()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    
    // Insert entries into the Mobile Entity
    func saveMobile(lanNam: String)
    {
        let mo = Mobile(context: persistentContainer.viewContext)
        mo.name = lanNam
        mo.id = UUID()
        do {
            print("saving")
            try persistentContainer.viewContext.save()
            MoData = getMobile()
        } catch{
            print("failed to save \(error)")
        }
    }
    
    // Fetch entries from the Mobile Entity
    func getMobile() -> [Mobile]
    {
        let fetchRequest: NSFetchRequest<Mobile> = Mobile.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            /*print(x.count)
            print(x[0].name)*/
            return x
        }catch{
            return []
        }
    }
    
    // Delete entries from the Mobile Entity
    func deleteMo(mobile: Mobile)
    {
        persistentContainer.viewContext.delete(mobile)
        do {
            print("saving")
            try persistentContainer.viewContext.save()
           
        } catch{
            print("failed to save \(error)")
        }
        
    }
    
}
    
    
    

