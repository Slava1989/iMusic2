//
//  MainTabBarController.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/29/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: class {
    func minimizeTrackDetailController()
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraion: NSLayoutConstraint!
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        setupTrackDetailView()
        searchVC.tabBarDelegate = self
        
        let libraryVC = Library()
        let hostVC = UIHostingController(rootView: libraryVC)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostVC.tabBarItem.title = "Library"
        
        viewControllers = [
            hostVC,
            generateViewController(rootViewController: searchVC, image: UIImage(named: "search")!, title: "Search")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
    private func setupTrackDetailView() {
        print("Set TrackDetailView")
        
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraion = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraion.isActive = true
        
        maximizedTopAnchorConstraint.isActive = true
        
//        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraion.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 0
                        self.trackDetailView.miniTrackView.alpha = 0
                        self.trackDetailView.maximazedStackView.alpha = 1
        },
                       completion: nil)
        
        guard let viewModel = viewModel else {
            return
        }
        
        self.trackDetailView.set(viewModel: viewModel)
        
    }
    
    func minimizeTrackDetailController() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraion.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
                        
                        self.trackDetailView.miniTrackView.alpha = 1
                        self.trackDetailView.maximazedStackView.alpha = 0
        },
                       completion: nil)
    }
}
