//
//  IdentifiableObject.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

protocol IdentifiableObject {

    static var identifier: String { get }    
}

extension IdentifiableObject {
    
    static var identifier: String {
        return "\(self)"
    }
}
