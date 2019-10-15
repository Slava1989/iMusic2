//
//  TrackCell.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/30/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    
    static let reuseId = "TrackCell"
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        trackNameLabel.text = viewModel.trackName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        
        trackImageView.sd_setImage(with: url, completed: nil)
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
    }
    @IBAction func addTrackDidTap(_ sender: Any) {
        print("44444")
        let defaults = UserDefaults.standard
        guard let cell = cell else {
            return
        }
        
        var listOfTracks = [SearchViewModel.Cell]()
        if let saveTrack = defaults.object(forKey: "tracks") as? Data {
            if let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(saveTrack) as? [SearchViewModel.Cell] {
                listOfTracks = decodedTracks
            }
        }
        
        listOfTracks.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks.self, requiringSecureCoding: false) {
            print("Success")
            defaults.set(savedData, forKey: "tracks")
        }
    }
    @IBAction func showInfoDidTap(_ sender: Any) {
        print("3333")
        let defaults = UserDefaults.standard
        if let saveTrack = defaults.object(forKey: "tracks") as? Data {
            if let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(saveTrack) as? [SearchViewModel.Cell] {
                decodedTracks.map { (track) in
                    print(track.trackName)
                }
            }
        }
    }
}
