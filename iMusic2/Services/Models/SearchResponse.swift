//
//  SearchResponse.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/29/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}
