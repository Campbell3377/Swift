//
//  personRecord.swift
//  personInfoSwiftUI
//
//  Created by Janaka Balasooriya on 2/11/23.
//

import Foundation
class personRecord
{
    var title:String? = nil
    var genre:String? = nil
    var price:Int16? = nil
    
    init(t:String, g:String, p:Int16) {
        self.title = t;
        self.genre = g;
        self.price = p;
    }
    
    func edit(newGenre:String, newPrice:Int16)
    {
        self.price = newPrice;
        self.genre = newGenre;
    }
    
}
