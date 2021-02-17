//
//  ResortView.swift
//  SnowSeeker
//
//  Created by PRABALJIT WALIA     on 16/02/21.
//

import SwiftUI

struct ResortView: View {
    let resort:Resort
    @Environment(\.horizontalSizeClass) var sizeClass
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

                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
                                            .padding(.vertical)
                }
                .padding(.horizontal)
                
            }
                
            }
            .navigationBarTitle(Text("\(resort.name),\(resort.country)"),displayMode: .inline)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
