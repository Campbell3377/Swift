//
//  ContentView.swift
//  personInfoSwiftUI
//
//  Created by Janaka Balasooriya on 2/11/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var personInfoDictionary:infoDictionary = infoDictionary()
    
    @State var title:String
    @State var genre:String
    @State var price:String
    
    
    @State var searchTitle:String
    @State var searchGenre:String
    @State var searchPrice:String
    
    @State var deleteS:String
    
    @State var list: [String]   //array to hold order of entries for next and prev
    @State var listIndex:Int    //Holds current index for next and prev
    @State var message:String   //Label text for no prev/next records message

    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(titleN: $title, genreN:$genre, priceN:$price, deleteTitle: $deleteS, pModel: personInfoDictionary,
                         listN: $list)
                
                dataEnterView( titleD: $title,genreD:$genre, priceD:$price)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(titleS: $searchTitle, genreS: $searchGenre, priceS: $searchPrice, messageS: $message)
                Spacer()
                ToolView(searchTitle: $searchTitle, editTitle: "", editGenre: "", editPrice: "", sGenre: $searchGenre , sPrice: $searchPrice, pModel: personInfoDictionary, sList: $list, sIndex: $listIndex, sMessage: $message)
               
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Person Info")
            
            
        }
    }
    
    
}
struct NaviView: View
{
    @Binding var titleN:String
    @Binding var genreN:String
    @Binding var priceN:String
    
    @State  var showingDeleteAlert = false
    @Binding  var deleteTitle: String
    @ObservedObject  var pModel : infoDictionary
    
    @Binding var listN: [String]
    
    var body: some View
    {
            Text("")
               .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:
                    {
                        print(pModel.getCount())
                        
                        pModel.add(titleN, genreN, Int16(priceN) ?? 0)
                        titleN = ""
                        genreN = ""
                        priceN = ""
                        listN.append(titleN);
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:
                    {
                        print(titleN)
                        showingDeleteAlert = true
                    },
                           label: {
                        Image(systemName: "trash")
                    })
                }
               }.alert("Delete Record", isPresented: $showingDeleteAlert, actions: {
                   TextField("Enter Title", text: $deleteTitle)

                   Button("Delete", action: {
                       
                       let title = deleteTitle
                       pModel.deleteRec(t:title)
                       var i:Int = 0
                       for str in listN{
                           if (str == title){
                               break;
                           }
                           i += 1;
                       }
                       let removed = listN.remove(at: i)
                       showingDeleteAlert = false
                       
                   })
                   Button("Cancel", role: .cancel, action: {
                       showingDeleteAlert = false
                   })
               }, message: {
                   Text("Please enter Title to Search.")
               })
        
        }
    
}

struct ToolView: View
{
    @Binding  var searchTitle: String
    
    @State var showingAlert = false
    @State var alert = ""
    @State var editTitle:String
    @State var editGenre:String
    @State var editPrice:String
    
    @Binding var sGenre:String
    @Binding var sPrice:String
    @ObservedObject  var pModel : infoDictionary
    
    @Binding var sList:[String]
    @Binding var sIndex:Int
    @Binding var sMessage:String
    
   // @State  var showingNoRecordsFoundDialog = false
    
    var body: some View
    {
        Text("")
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button(action:
                    {
                            showingAlert = true
                            alert = "Search Record"
                    },
                           label: {
                        Image(systemName:"eye")
                            .scaledToFit()
                    })
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(action:
                    {
                            showingAlert = true
                            alert = "Edit Record"
                    },
                           label: {
                        Text("Edit")
                    })
                }
                
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action:
                    {
                        if (sIndex + 1) < pModel.getCount() {
                            sIndex += 1;
                            let title = sList[sIndex]
                            let p =  pModel.search(t: title)
                            if let x = p {
                                searchTitle = title
                                sGenre = x.genre!
                                sPrice = String(x.price!)
                                sMessage = ""
                                print("In Next")
                            }else{
                                sGenre = "No Record "
                                sPrice =  "No Record "
                                print("No Record")
                            }
                        }
                        else {
                            sMessage = "No more records."
                        }
                    },
                           label: {
                        Text("Next")
                    })
                    
                    Spacer()
                    Button(action:
                    {
                        if (sIndex - 1) >= 0 {
                            sIndex -= 1;
                            let title = sList[sIndex]
                            let p =  pModel.search(t: title)
                            if let x = p {
                                searchTitle = title
                                sGenre = x.genre!
                                sPrice = String(x.price!)
                                sMessage = ""
                                print("In Prev")
                            }else{
                                sGenre = "No Record "
                                sPrice =  "No Record "
                                print("No Record")
                            }
                        }
                        else {
                            sMessage = "Showing first record."
                        }
                    },
                           label: {
                        Text("Prev")
                    })
                    Spacer()
                }
            }.alert(alert, isPresented: $showingAlert, actions: {
                if alert == "Search Record" {
                    TextField("Enter Title", text: $searchTitle)

                    Button("Search", action: {
                        
                        let title = searchTitle
                        let p =  pModel.search(t: title)
                        if let x = p {
                            sGenre = x.genre!
                            sPrice = String(x.price!)
                            sIndex = sList.firstIndex(of: title) ?? 0
                            print("In search")
                        }else{
                            sGenre = "No Record "
                            sPrice =  "No Record "
                            print("No Record")
                        }
                        showingAlert = false
                        
                    })
                    Button("Cancel", role: .cancel, action: {
                        showingAlert = false
                    })
                }
                else if alert == "Edit Record" {
                    TextField("Enter Title", text: $editTitle)
                    TextField("Enter Genre", text: $editGenre)
                    TextField("Enter Price", text: $editPrice)

                    Button("Edit", action: {
                        
                        let title = searchTitle
                        let p =  pModel.search(t: title)
                        if p != nil {
                            pModel.edit(t: editTitle, g: editGenre, p: Int16(editPrice) ?? 0)
                            print("In search")
                        }else{
                            sGenre = "No Record "
                            sPrice =  "No Record "
                            print("No Record")
                        }
                        showingAlert = false
                        
                    })
                    Button("Cancel", role: .cancel, action: {
                        showingAlert = false
                    })
                }
                
            }, message: {
                Text("Please enter Title.")
            })
    }
    
}


struct dataEnterView: View
{
    @Binding var titleD:String
    @Binding var genreD:String
    @Binding var priceD:String
    
    var body: some View
    {
        HStack{
           
            Text("Title:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Title", text: $titleD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Genre:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Genre", text: $genreD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Price", text: $priceD)
                .textFieldStyle(.roundedBorder)
                
        }
    }
    
}

struct SearchView: View
{
    
    @Binding var titleS:String
    @Binding var genreS:String
    @Binding var priceS:String
    
    @Binding var messageS:String
    
    var body: some View
    {
        VStack {
            HStack{
               
                Text("Title:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("", text: $titleS)
                    .textFieldStyle(.roundedBorder)
                    
            }
            HStack{
               
                Text("Genre:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("", text: $genreS)
                    .textFieldStyle(.roundedBorder)
                    
            }
            HStack{
               
                Text("Price:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("", text: $priceS)
                    .textFieldStyle(.roundedBorder)
                    
            }
            TextField("", text: $messageS)
        }
        
        
        
//        HStack{
//
//            Text("Age:")
//                .foregroundColor(.blue)
//            Spacer()
//            TextField("", text: $ageS)
//                .textFieldStyle(.roundedBorder)
//
//        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "janaka", genre: "Horror", price: "12", searchTitle: "", searchGenre: "", searchPrice: "", deleteS: "", list: [], listIndex: 0, message:"")
    }
}
