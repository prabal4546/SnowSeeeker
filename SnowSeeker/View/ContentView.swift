//
//  ContentView.swift
//  SnowSeeker
//
//  Created by PRABALJIT WALIA     on 16/02/21.
//

import SwiftUI

enum SortType: String,CaseIterable,Equatable{
    case none = "None"
    case byName = "By Name"
    case byCountry = "By Country"
}
enum FilterType: String,CaseIterable,Equatable{
    case none = "None"
    case bySize = "By Size"
    case byCountry = "By Country"
    case byPrice = "By Price"
}


struct ContentView: View {
    @State private var sortType: SortType = .none
    @State private var filterType: FilterType = .none
    @State private var showingActionSheet = false
    var sortedResorts:[Resort]{
        switch sortType{
        case .none:
            return resorts
        case .byName:
            return resorts.sorted(by: {$0.name<$1.name})
        case .byCountry:
            return resorts.sorted(by: {$0.country<$1.country})
            
        }
    }


    
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort:resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
 
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }.layoutPriority(1)
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action:{
                self.showingActionSheet = true
            }){
                Image(systemName: "list.and.film")
                Text("Sort")
            }
            ,trailing:Button(action:{

            }){
                Image(systemName:"camera.filters")
                Text("Filter")
            })
            .actionSheet(isPresented:$showingActionSheet){
                ActionSheet(title: Text("Sort"),buttons:[
                                .default(Text("Name"),action:{
//                                    self.sortType = "By Name"
                                }),
                                .default(Text("Country"),action:{
//                                    self.sortType = "By Country"
                                }),
                                .cancel()])
            }

            WelcomeView()
                
        }.environmentObject(favorites)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
