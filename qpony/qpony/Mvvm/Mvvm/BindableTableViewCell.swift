//
//  BindableTableViewCell.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

class BindableTableViewCell<T: BaseViewModel & IdentifiableObject>: UITableViewCell, GenericBindable, IdentifiableObject {
    
    static var identifier: String {
        return T.identifier
    }
    
    weak var viewModel: T?
        
    func bind(source: T) {
        self.viewModel = source      
    }
}
