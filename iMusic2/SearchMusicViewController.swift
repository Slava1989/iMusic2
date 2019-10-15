//
//  SearchViewController.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/29/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchMusicViewController: UITableViewController {
    
    
    var networkService = NetworkService()
    private var timer: Timer?
    let searchCotroller = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchCotroller
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchCotroller.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.artistName)\n\(track.trackName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        return cell
    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}
