//
//  WebService.swift
//  RandomQuoteAndImage
//
//  Created by karlis.stekels on 03/02/2023.
//

import Foundation

class WebService {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        
        // Will create Group with more concurrent tasks
        try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
            for id in ids {
                group.addTask { [self] in
                    return (id, try await getRandomImage(id: id))
                }
            }
            
            for try await (_, randomImage) in group {
                randomImages.append(randomImage)
            }
        })
        
        return randomImages
    }
    
    func getRandomImage(id: Int) async throws -> RandomImage {
        guard let url = Constants.Urls.getRandomImageUrl() else {
            throw NetworkError.badURL
        }
        
        guard let randomQuoteUrl = Constants.Urls.randomQuoteURL else {
            throw NetworkError.badURL
        }
        
        // Two Concurrent tasks
        async let (imageData, _) = URLSession.shared.data(from: url)
        async let (quoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quite: quote)
        
    }
}
