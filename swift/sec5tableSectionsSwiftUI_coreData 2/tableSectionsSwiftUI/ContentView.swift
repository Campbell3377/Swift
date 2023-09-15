//
//  ContentView.swift
//  tableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/18/23.
//

import SwiftUI

struct section:Identifiable
{
    let id = UUID()
    let name: String
}

struct ContentView: View {
    
    //module that manage the coreData
    @State var dataController: coreDataController = coreDataController()

    // tableview sections
    @State  var sectionData = [
        section(name:"Programming Languages"),
        section(name:"Operating Systems"),
        section(name:"Mobile Platforms")]

    // boolean variable that enable show/hide data insert view
    @State var toInsertView = false
    
    /*variables to read data and the type (0: programming languages, 1: Operating systems, 2: Mobile platforms) to insert */
    @State  var data = ""
    @State  var type = ""
    //
   // @State var sectionType = ["Programming Languages", "Operating Systems", "Mobile Platforms"]
    
    var body: some View {
        NavigationView
        {
    
            List {
                Section(sectionData[0].name)
                {
                    ForEach(dataController.LanData) { datum in
                        if datum.name != nil
                        {
                            NavigationLink(destination:
                                            DetailView(name: datum.name ?? ""))
                            {
                                if datum.name != nil
                                {
                                    Text(datum.name ?? "")
                                }
                            }
                        }
                    }.onDelete(perform: {IndexSet in
                        for index in IndexSet {
                            // call delete language method in coreData manager Module
                            let language = dataController.LanData[index]
                            dataController.deleteLanguage(lan: language)
                            }
                  
                        })
                    
                }
                Section(sectionData[1].name)
                {
                    ForEach(dataController.getOS()) { datum in
                        if datum.name != nil
                        {
                            NavigationLink(destination: DetailView(name: datum.name!))
                            {
                                Text(datum.name!)
                            }
                        }
                    }.onDelete(perform: {IndexSet in
                        for index in IndexSet {
                            // call delete OS method in coreData manager Module
                            let os = dataController.OSData[index]
                            dataController.deleteOs(operatingS: os)
                            }
                    })
                    
                }
                Section(sectionData[2].name)
                {
                   
                        ForEach(dataController.getMobile()) { datum in
                        if datum.name != nil
                        {
                            NavigationLink(destination: DetailView(name: datum.name!))
                            {
                                Text(datum.name!)
                            }
                      }
                    }.onDelete(perform: {IndexSet in
                        
                        for index in IndexSet {
                        // call delete Mobile method in coreData manager Module
                        let mo = dataController.MoData[index]
                        dataController.deleteMo(mobile: mo)
                        }
                        
                    })
                    
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("List Introduction")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                         
                            toInsertView = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.alert("Insert", isPresented: $toInsertView, actions: {
                   
                    TextField("Data:", text: $data)
                    TextField("Data Type (0, 1, or 2):", text: $type)

                    Button("Insert", action: {
                        if Int(type) == 0{
                            dataController.saveLanguage(lanNam: data)
                            toInsertView = false
                          
                        }else if Int(type) == 1
                        {
                            dataController.saveOS(lanNam: data)
                            toInsertView = false
                        }else if Int(type) == 2
                        {
                            dataController.saveMobile(lanNam: data)
                            toInsertView = false
                        }else
                        {
                          print("Invald Type")
                          toInsertView = false
                        }
                        
                    })
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                }, message: {
                    Text("Please Enter Data Programming Language, OS, or Mobile Platform to Insert")
                })
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: coreDataController())
    }
}
