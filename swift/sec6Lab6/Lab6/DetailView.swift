//
//  DetailView.swift
//  Lab6
//
//  Created by Sean Campbell on 3/28/23.
//

import SwiftUI

struct DetailView: View {
    var name:String
    var pic:UIImage
    var desc:String
    var body: some View {
        VStack{
            Text(name)
            Image(uiImage: pic)
                .resizable()
                .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 250, alignment: .topLeading)
                        .clipped()
            Text(desc)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
