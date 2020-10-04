//
//  BaseViewModel.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

protocol MyEvent { }

protocol EventHandler: class {
    
    func handleEvent(_ event: MyEvent)
}

protocol EventSender {
    
    var eventHandler: EventHandler? { get set }
    
    func invokeEvent(_ event: MyEvent)
}

extension EventSender {
    
    func invokeEvent(_ event: MyEvent) {
        self.eventHandler?.handleEvent(event)
    }
}

protocol BindingTarget: class {
    
    func viewModelDidUpdate(_ updatedProperty: AnyKeyPath?)
}

class BaseViewModel: EventHandler, EventSender {
        
    weak var bindingTarget: BindingTarget?
        
    weak var eventHandler: EventHandler?
        
    func handleEvent(_ event: MyEvent) {
        if let handler = self.eventHandler {
            handler.handleEvent(event)
        }
    }
        
    func viewModelDidUpdate(_ updatedKeyPath: AnyKeyPath?) {
        self.bindingTarget?.viewModelDidUpdate(updatedKeyPath)
    }
}

class RootViewModel: BaseViewModel {
            
    required override init() { }
        
    func bindingDidComplete() { }
}
