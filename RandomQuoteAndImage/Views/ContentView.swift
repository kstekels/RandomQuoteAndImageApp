//
//  ContentView.swift
//  RandomQuoteAndImage
//
//  Created by karlis.stekels on 03/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var randomImageListVM = RandomImageListViewModel()
    
    var body: some View {
        NavigationView {
            List(randomImageListVM.randomImages) { randomImage in
                
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 100, height: 150)
                            .aspectRatio(contentMode: .fill)
                    }
                    Text(randomImage.quote)
                }
                
            }
            .listStyle(.plain)
            .task {
                await randomImageListVM.getRandomImages(ids: Array(100...120))
            }
            .navigationTitle("Random Images/Quotes")
            .toolbar {
                Button {
                    Task {
                        await randomImageListVM.getRandomImages(ids: Array(100...120))
                    }
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
