//
//  Bindable.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

protocol Bindable: class {
    
    func bind(source: BaseViewModel)
}

protocol GenericBindable: Bindable {
    
    associatedtype ViewModelType: BaseViewModel
    
    var viewModel: ViewModelType? { get set }
    
    func bind(source: ViewModelType)
    
    func invokeEvent(_ event: MyEvent)
}

extension GenericBindable {
    
    func bind(source: BaseViewModel) {
		if let source = source as? ViewModelType {
			self.bind(source: source)
		}
    }
    
    func bind(source: ViewModelType) {
        self.viewModel = source
        
        if let bindableTarget = self as? BindingTarget {
            source.bindingTarget = bindableTarget
        }               
    }
    
    func invokeEvent(_ event: MyEvent) {
        self.viewModel?.handleEvent(event)
    }
}
