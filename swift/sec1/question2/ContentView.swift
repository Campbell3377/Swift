//
//  ContentView.swift
//  question2
//
//  Created by Sean Campbell on 1/11/23.
//

import SwiftUI

struct ContentView: View {
   /* @State var name: String = ""
    @State var age: String = ""
    @State var greeting: String = "Welcome"
    @State var imageName:String = ""
    */
      @State var val: Double = 0
    
    var body: some View {
       
        show()
        
        
     /* VStack {
            Text("Welcome to CSE 335")
             
            Spacer()
            
            HStack{
            Text("Name: " )
             Spacer()
             Spacer()
            TextField("name here", text: $name, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
            })
            }
            
             HStack{
             Text("Age: " )
             Spacer()
             Spacer()
            TextField("age here", text: $age, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
            })
            }
            
             Spacer()
            Button(action: {
                self.greeting = "Welcome \(self.name)"
                self.imageName = "smily"
                
            }) {
                Text("Click Me !")
            }
             Spacer()
        
            Text(greeting)
           
            Spacer()
        
            Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 40.0, height: 40, alignment: .center)
        
          //Spacer()
         
        }.padding()
            
            */
       
     
        
    }
}

struct show : View
{
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var greeting: String = "Welcome"
    @State var imageName:String = ""
    var body: some View {
    VStack {
               Text("Welcome to CSE 335")
               Spacer()
               
               HStack{
               Text("First Name: " )
                Spacer()
                Spacer()
               TextField("first name here", text: $firstName, onEditingChanged: { (changed) in
                   print("firstName onEditingChanged - \(changed)")
                   
               })
               }
                HStack{
                Text("Last Name: " )
                Spacer()
                Spacer()
               TextField("last name here", text: $lastName, onEditingChanged: { (changed) in
                   print("lastName onEditingChanged - \(changed)")
               })
               }
               Spacer()
               Button(action: {
                   self.greeting = "\(self.firstName) \(lastName) Welcome to CSE 335"
               }) {
                   Text("Enter !")
               }
                Spacer()
               Text(greeting)
               Spacer()
               Image(imageName)
               .resizable()
               .scaledToFit()
               .frame(width: 40.0, height: 40, alignment: .center)
            
           }.padding()
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
