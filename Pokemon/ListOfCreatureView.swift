//
//  ListOfCreatureView.swift
//  Pokemon
//
//  Created by Mami Ravaloarison on 10/30/24.
//

import SwiftUI

struct ListOfCreatureView: View {
    var name: String
    var url: String
    var creature = CreatureDetail()
    
    var body: some View {
        HStack (alignment: .center, spacing: 12) {
            AsyncImage(url: URL(string: creature.ImgURL)) { image in image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 57, height: 57, alignment: .center)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.clear)
                    .frame(width:57, height: 57)
            }
            VStack (alignment: .leading, spacing: 3) {
                Text(name.capitalized)
                HStack {
                    ForEach([("Width:", creature.weight), ("Height:", creature.height)], id: \.0) { label, value in
                        HStack {
                            Text(label)
                            Text(String(format: "%.1f", value))
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .task {
            creature.urlString = url
            await creature.getData()
        }
    }
}

#Preview {
    ListOfCreatureView(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
