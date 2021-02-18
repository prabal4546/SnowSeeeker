//
//  ResortView.swift
//  SnowSeeker
//
//  Created by PRABALJIT WALIA     on 16/02/21.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct ResortView: View {
    let resort:Resort
    @EnvironmentObject var favorites:Favorites
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: String?
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack{
                Image(decorative: resort.country)
                    .resizable()
                    .scaledToFit()
                    HStack{
                        if sizeClass == .compact{
                        Spacer()
                            VStack{ResortDetailsView(resort: resort)}
                        VStack{SkiDetailsView(resort: resort)}
                        Spacer()
                        }else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height:0)
                            SkiDetailsView(resort: resort)
                        }
                        
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    Group{
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text("Facilities")
                            .font(.headline)
                        
                        HStack{ForEach(resort.facilities){facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }.padding(.vertical)}
                    }
                    .padding(.horizontal)
                    Button(favorites.contains(resort) ? "Remove from Favorites":"Add to favorites"){
                        if self.favorites.contains(self.resort){
                            self.favorites.remove(self.resort)
                        }else{
                            self.favorites.add(self.resort)
                        }
                    }
                    .padding()
                
            }
                
            }
            .navigationBarTitle(Text("\(resort.name),\(resort.country)"),displayMode: .inline)
            .alert(item: $selectedFacility){facility in
                Facility.alert(for: facility)
                
            }
        }
    }
    
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
