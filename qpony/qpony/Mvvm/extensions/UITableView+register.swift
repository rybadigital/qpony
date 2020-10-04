//
//  UITableView+register.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

extension UITableView {

    func register<T>(type: T.Type) where T: UITableViewCell & IdentifiableObject {
        let nibName = "\(type)"
        
        assert(Bundle.main.path(forResource: nibName, ofType: ".nib") != nil, "Associated XIB file should be named \(nibName).xib")
        
        let nib = UINib(nibName: nibName, bundle: nil)
        let identifier = type.identifier
        self.register(nib, forCellReuseIdentifier: identifier)
    }
        
    func dequeueBindableCell<I>(for indexPath: IndexPath,
                                in items: [I],
                                eventHandler: EventHandler?) -> UITableViewCell where I: BaseViewModel & IdentifiableObject {
        let row = indexPath.row
        
        let item = items[row]
        item.eventHandler = eventHandler
        let identifier = type(of: item).identifier
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? (UITableViewCell & Bindable) else {
            fatalError("\(self) No registred table view cell can be found with identifier \(identifier)")
        }
        cell.bind(source: item)
        
        return cell
    }
}
