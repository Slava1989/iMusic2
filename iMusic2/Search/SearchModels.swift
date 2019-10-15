//
//  SearchModels.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/30/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTracks(searchTerm: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTracks(searchResponse: SearchResponse?)
        case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTracks(searchViewModel: SearchViewModel)
        case dispalyFooterView
      }
    }
  }
}

class SearchViewModel: NSObject, NSCoding {
    @objc(_TtCC7iMusic215SearchViewModel4Cell)class Cell: NSObject, NSCoding {
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
        var previewURL: String?
        
        init(iconUrlString: String?,
             trackName: String,
             collectionName: String,
             artistName: String,
             previewURL: String?) {
            self.iconUrlString = iconUrlString
            self.trackName = trackName
            self.collectionName = collectionName
            self.artistName = artistName
            self.previewURL = previewURL
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(iconUrlString, forKey: "iconUrlString")
            coder.encode(trackName, forKey: "trackName")
            coder.encode(collectionName, forKey: "collectionName")
            coder.encode(artistName, forKey: "artistName")
            coder.encode(artistName, forKey: "artistName")
        }
        
        required init?(coder: NSCoder) {
            iconUrlString = coder.decodeObject(forKey: "iconUrlString") as? String? ?? ""
            trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
            collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
            artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
            previewURL = coder.decodeObject(forKey: "previewURL") as? String? ?? ""
        }
    }
    
    init(cells: [Cell]) {
        self.cells = cells
    }
    
    let cells: [Cell]
    
    func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [SearchViewModel.Cell] ?? []
    }
}
