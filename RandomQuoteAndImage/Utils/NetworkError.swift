//
//  NetworkError.swift
//  RandomQuoteAndImage
//
//  Created by karlis.stekels on 03/02/2023.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidImageId(Int)
    case decodingError
}
