//
//  RandomImage.swift
//  RandomQuoteAndImage
//
//  Created by karlis.stekels on 03/02/2023.
//

import Foundation


struct RandomImage: Decodable {
    let image: Data
    let quite: Quote
}

struct Quote: Decodable {
    let content: String
}
