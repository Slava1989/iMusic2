//
//  Nib.swift
//  iMusic2
//
//  Created by Veaceslav Chirita on 10/4/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
