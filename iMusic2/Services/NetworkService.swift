//
//  NetworkService.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/29/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)", "limit": "100", "media": "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received ", error)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let objs = try decoder.decode(SearchResponse.self, from: data)
                completion(objs)
            } catch let jsonError {
                print("Failed to decode json ", jsonError)
                completion(nil)
            }
        }
    }
    
}
