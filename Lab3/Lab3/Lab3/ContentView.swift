//
//  ContentView.swift
//  Lab3
//
//  Created by lihe5 on 2/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieinfoDictionary:movieDictionary = movieDictionary()

    @State var title:String
    @State var genre:String
    @State var price:String
    
    @State var searchTitle:String
    @State var searchGenre:String
    @State var searchPrice:String
    
    @State var deleteT:String
    @State var editTitle:String
    @State var newGenre: String
    @State var newPrice: String
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(titleN: $title, genreN: $genre, priceN: $price, deleteTitle: $deleteT, mModel: movieinfoDictionary)
                dataEnterView( titleD: $title, genreD: $genre, priceD: $price)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(titleS:$searchTitle, genreS: $searchGenre, priceS: $searchPrice)
                Spacer()
                ToolView(searchTitle:"", sTitle: $searchTitle, sGenre: $searchGenre, sPrice: $searchPrice, eTitle: $editTitle, nGenre: $newGenre, nPrice: $newPrice, mModel: movieinfoDictionary)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Movie Info")
        }
    }
}

struct NaviView: View
{
    @Binding var titleN:String
    @Binding var genreN:String
    @Binding var priceN:String
    
    @State var showingDeleteAlert = false
    @Binding var deleteTitle: String
    @ObservedObject var mModel: movieDictionary
    
    var body: some View
    {
        Text("")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:
                    {
                        print(mModel.getCount())
                        mModel.add(titleN, genreN, Double(priceN) ?? 0.0)
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:
                            {
                        print(titleN)
                        showingDeleteAlert = true
                    },
                           label: {
                        Image(systemName: "trash")
                    })
                }
            }.alert("Delete Record", isPresented: $showingDeleteAlert,
                actions: {
                
                
                TextField("Enter title", text: $deleteTitle)

                Button("Delete", action: {
                    let title = deleteTitle
                    mModel.deleteRecord(t: title)
                    showingDeleteAlert = false
                })
                Button("Cancel", role: .cancel, action: {
                    showingDeleteAlert = false
                })
            }, message: {
                Text("Please enter Title to Delete.")
            })
    }
}

struct ToolView: View
{
    @State var searchTitle: String
    //@State var editTitle: String
    @State var showingSearchAlert = false
    @State var editInfo = false
    @State var result: String = ""
    
    @Binding var sTitle: String
    @Binding var sGenre: String
    @Binding var sPrice: String
    @Binding var eTitle: String
    @Binding var nGenre: String
    @Binding var nPrice: String
    @ObservedObject var mModel: movieDictionary
    var body: some View
    {
        Text(result)
            .foregroundColor(.red)
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button(action:
                            {
                        showingSearchAlert = true
                    },
                           label: {
                        Image(systemName: "eye")
                            .scaledToFit()
                    })
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action:
                            {
                        editInfo = true
                        //implement edit function here
                    }, label: {
                    Text("Edit")
                    })
                    Spacer()
                    Button(action:
                            {
                        //implement next function here
                        //let title = searchTitle
                        let title = sTitle
                        let m = mModel.getPrev(t: title)
                        let firstKey = mModel.getFirst()
                        if title == firstKey
                        {
                            self.result = "It is the first record"
                        }
                        else
                        {
                            sTitle = m!.title!
                            sGenre = m!.genre!
                            sPrice = String(m!.price!)
                            self.result = ""
                        }
                        
                    }, label: {
                        Text("Prev")
                    })
                    
                    Spacer()
                    Button(action:
                            {
                        //implement prev function here
                        //let title = searchTitle
                        let title = sTitle
                        let m = mModel.getNext(t: title) // m is movie record
                        let lastKey = mModel.getLast()
                        if  title == lastKey {
                            self.result = "No more records"
                        }
                        else
                        {
                            sTitle = m!.title!
                            sGenre = m!.genre!
                            sPrice = String(m!.price!)
                            self.result = ""
                        }
                        
                    },
                           label: {
                        Text("Next")
                    })
                    Spacer()
                }
            }.alert("Search Record", isPresented: $showingSearchAlert, actions: {
                TextField("Enter title", text:$searchTitle)
                
                Button("Search", action: {
                    let title = searchTitle
                    let m = mModel.search(t: title)
                    if let x = m {
                        sTitle = title
                        sGenre = x.genre!
                        sPrice = String(x.price!)
                        
                        print("In search")
                    }else{
                        sTitle = "No Record "
                        sGenre = ""
                        sPrice = ""
                        print("No Record")
                    }
                    showingSearchAlert = false
                })
                Button("Cancel", role: .cancel, action: {
                    showingSearchAlert = false
                })
            }, message: {
                Text("Please enter Title to search.")
            }).alert("Edit Record", isPresented: $editInfo, actions: {
                TextField("Enter title", text: $eTitle)
                TextField("Enter new genre", text: $nGenre)
                TextField("Enter new price", text: $nPrice)
                Button("Edit", action: {
                    let title = eTitle
                    let genre = nGenre
                    let price = nPrice
                    let m = mModel.editRecord(t:title, g:genre, p: price)
                    sTitle = title
                    sGenre = m!.genre!
                    sPrice = String(m!.price!)
                    editInfo = false
                    self.result = ""
                })
                Button("Cancel", role: .cancel, action: {
                    editInfo = false
                })
            }, message: {
                Text("Please enter title to edit.")
            })
    }
}

struct SearchView: View
{
    @Binding var titleS: String
    @Binding var genreS: String
    @Binding var priceS: String
    
    var body: some View
    {
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
           
            Text("price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $priceS)
                .textFieldStyle(.roundedBorder)
                
        }
        
        
        
        
    }
}

struct dataEnterView: View
{
    @Binding var titleD: String
    @Binding var genreD: String
    @Binding var priceD: String
    var body: some View
    {
        HStack{
            Text("Title: ")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter title", text: $titleD)
                .textFieldStyle(.roundedBorder)
        }
        HStack{
            Text("Genre: ")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter genre", text: $genreD)
                .textFieldStyle(.roundedBorder)
        }
        
        HStack {
            Text("Price: ")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter price: ", text: $priceD)
                .textFieldStyle(.roundedBorder)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Spider-man", genre: "Adventure", price: "9.34", searchTitle: "", searchGenre:"", searchPrice: "", deleteT: "", editTitle: "", newGenre: "", newPrice: "")
    }
}
