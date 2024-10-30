//
//  Creatures.swift
//  Pokemon
//
//  Created by Mami Ravaloarison on 10/29/24.
//

import Foundation

@Observable // watch obj for changes so swiftUI redraw UI when needed
class Creatures {
    private struct Returned: Codable {
        var next: String
        var count: Int
        var results: [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray: [Creature] = []
    
    func getData() async {
        print("Accessing url as string \(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from the String")
            return
        }
        
        // Try and Except
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // try to decode JSON data into our data strcut
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("Could not decode JSON return from data")
                return
            }
            
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("Could not retrieve data from url \(urlString)")
        }
    }
}
