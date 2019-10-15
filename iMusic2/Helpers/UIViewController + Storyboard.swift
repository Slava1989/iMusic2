//
//  UIViewController + Storyboard.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 9/30/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyBoard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("No initial view controller in \(name) storyboard")
        }
    }
    
}
