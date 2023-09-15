//
//  DetailView.swift
//  tableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/18/23.
//

import SwiftUI

struct DetailView: View {
    var name:String
    
    var body: some View {
        Text(name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name:"Hi")
    }
}
