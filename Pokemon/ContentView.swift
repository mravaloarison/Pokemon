//
//  ContentView.swift
//  Pokemon
//
//  Created by Mami Ravaloarison on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    var creatures = Creatures()
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            List(creatures.creaturesArray, id: \.self) { creature in
                LazyVStack {
                    NavigationLink {
                        ListOfCreatureView(name: creature.name, url: creature.url)
                    } label: {
                        ListOfCreatureView(name: creature.name, url: creature.url)
                    }
                }
            }
        }
        .searchable(text: $searchQuery)
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    ContentView()
}
