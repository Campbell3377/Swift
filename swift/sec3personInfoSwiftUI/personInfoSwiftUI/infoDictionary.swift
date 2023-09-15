//
//  infoDictionary.swift
//  personInfoSwiftUI
//
//  Created by Janaka Balasooriya on 2/11/23.
//

import Foundation
class infoDictionary: ObservableObject
{
    // dictionary that stores person records
    @Published var infoRepository : [String:personRecord] = [String:personRecord] ()
    init() { }
  
    func add(_ title:String, _ genre:String, _ price:Int16)
    {
        let pRecord =  personRecord(t: title, g:genre, p: price)
        infoRepository[pRecord.title!] = pRecord
        
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func add(p:personRecord)
    {
        print("adding" + p.title!)
        infoRepository[p.title!] = p
        
    }
    
    func search(t:String) -> personRecord?
    {
        var found = false
        
        for (title, _) in infoRepository
        {
            if title == t {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[t]
        }else  {
     
            return nil
            }
    }
    
    func deleteRec(t:String)
    {
        infoRepository[t] = nil
        
    }
    
    func edit(t:String, g:String, p: Int16){
        infoRepository[t]?.edit(newGenre: g, newPrice: p);
    }
}
