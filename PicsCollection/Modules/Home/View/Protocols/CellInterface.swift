//
//  CellInterface.swift
//  YALLayoutTransitioning
//
//  Created by Gati Shah on 7/18/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit

protocol CellInterface {
    
    static var id: String { get }
    static var cellNib: UINib { get }
    
}

extension CellInterface {
    
    static var id: String {
        return String(describing: Self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
}
