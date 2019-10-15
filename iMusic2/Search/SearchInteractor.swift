//
//  SearchInteractor.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/30/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

    var networkService = NetworkService()
  var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
    
    switch request {
    case .getTracks(let searchTerm):
        print("Interactor .getTracks")
        presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
        networkService.fetchTracks(searchText: searchTerm) { [weak self] (searchResponse) in
            self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: searchResponse))
        }
    }
    
  }
  
}
