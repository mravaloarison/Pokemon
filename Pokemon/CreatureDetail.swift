//
//  CreatureDetail.swift
//  Pokemon
//
//  Created by Mami Ravaloarison on 10/29/24.
//

import Foundation

@Observable // watch obj for changes so swiftUI redraw UI when needed
class CreatureDetail {
    private struct Returned: Codable {
        var weight: Double
        var height: Double
        var sprites: Sprite
    }
    
    private struct Sprite: Codable {
        var other: Home
    }

    private struct Home: Codable {
        var home: fontDefault
    }
    
    private struct fontDefault: Codable {
        var front_default: String
    }
    
    var urlString: String = ""
    
    var weight = 0.0
    var height = 0.0
    var ImgURL = ""
    
    
    func getData() async {
        print("Accessing url as string \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from the string")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // try to decode JSON data into our data strcut
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("Could not decode JSON return from data")
                return
            }
            
            self.weight = returned.weight
            self.height = returned.height
            self.ImgURL = returned.sprites.other.home.front_default
        } catch {
            print("Could not retrieve data from url \(urlString)")
        }
    }

}
