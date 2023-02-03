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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
