//
//  Favorites.swift
//  SnowSeeker
//
//  Created by PRABALJIT WALIA     on 17/02/21.
//

import SwiftUI
class Favorites: ObservableObject {
    private var resorts:Set<String>
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data

        // still here? Use an empty array
        self.resorts = []
    }
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
      }
    func add(_ resort:Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    func remove(_ resort:Resort){
        objectWillChange.send()
                resorts.remove(resort.id)
                save()
    }
    func save(){
        
    }
    
}
