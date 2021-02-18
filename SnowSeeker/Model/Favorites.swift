//
//  Favorites.swift
//  SnowSeeker
//
//  Created by PRABALJIT WALIA     on 17/02/21.
//

import SwiftUI
class Favorites: ObservableObject {
    private var resorts:Set<String>
    static let saveKey = "Favorites"
    
    init() {
        // load our saved data
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//              if let decoded = try? JSONDecoder().decode([Favorites].self, from: data) {
//                  self.favorite = decoded
//                  return
//              }
//          }
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
        if let encoded = try? JSONEncoder().encode(resorts){
            UserDefaults.standard.set(encoded,forKey: Self.saveKey)
        }
        
    }
    
}
