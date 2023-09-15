//
//  ContentView.swift
//  coreData1
//
//  Created by Janaka Balasooriya on 3/5/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contacts.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Contacts>
    
    @State var toInsertView = false
    @State var name:String
    @State var phone: String
    @State var address: String

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.name!)")
                    } label: {
                        Text(item.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        toInsertView = true
                        //Label("Add Item", systemImage: "plus")
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }.alert("Insert", isPresented: $toInsertView, actions: {
                
                TextField("Name:", text: $name)
                TextField("Phone:", text: $phone)
                TextField("Address:", text: $address)

                Button("Insert", action: {
                    
                    addItem(n:name, p: phone, a: address)
                    toInsertView = false
                    
                })
                Button("Cancel", role: .cancel, action: {
                    toInsertView = false
                })
            }, message: {
                Text("Please Enter Data  to Insert")
            })
            //Text("Select an item")
        }
    }

    private func addItem(n: String, p: String, a: String) {
        withAnimation {
            let newItem = Contacts(context: viewContext)
            newItem.name = n
            newItem.phone = p
            newItem.address = a

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(name:"", phone: "", address: "").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
