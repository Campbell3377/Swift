//
//  infoDictionary.swift
//  MovieApp
//
//  Created by Sean Campbell on 2/25/23.
//
import Foundation
class infoDictionary: ObservableObject
{
    // dictionary that stores person records
    @Published var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    init() { }
  
    func add(_ title:String, _ genre:String, _ price:Int16)
    {
        let mRecord =  movieRecord(t: title, g:genre, p: price)
        infoRepository[mRecord.title!] = mRecord
        
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func add(m:movieRecord)
    {
        print("adding" + m.title!)
        infoRepository[m.title!] = m
        
    }
    
    func search(t:String) -> movieRecord?
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
