//
//  ContentView.swift
//  Lab6
//
//  Created by Sean Campbell on 3/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var dataController: coreDataController = coreDataController()
    
    @State var toInsertView = false
    @State var isShowPhotoLibrary = false
    
    @State var city = ""
    @State var image = UIImage()
    @State var desc = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(dataController.CityData) { datum in
                    if datum.name != nil
                    {
                        NavigationLink(destination:
                                        DetailView(name: datum.name ?? "", pic: (UIImage(data: datum.picture!) ?? UIImage(systemName: "smiley"))!, desc: datum.desc ?? ""))
                        {
                            HStack {
                                Image(uiImage: UIImage(data: datum.picture!) ?? UIImage(systemName: "smiley")!).resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                Text(datum.name ?? "")
                                
                            }
                        }
                    }
                }.onDelete(perform: {IndexSet in
                    for index in IndexSet {
                        // call delete language method in coreData manager Module
                        let city = dataController.CityData[index]
                        dataController.deleteCity(city: city)
                    }
                    
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                        toInsertView = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }.alert("Insert", isPresented: $toInsertView, actions: {
                
                TextField("Name: ", text: $city)
                Button(action: {
                    self.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                            
                        Text("Photo library")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                TextField("Description: ", text: $desc)
                
                Button("Insert", action: {
                    dataController.saveCity(name: city, pic: image, desc: desc)
                    toInsertView = false
                 
                    
                })
                Button("Cancel", role: .cancel, action: {
                    toInsertView = false
                })
            }, message: {
                Text("Please Enter City Information")
            })
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            Text("Select an item")
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: coreDataController())
    }
}
