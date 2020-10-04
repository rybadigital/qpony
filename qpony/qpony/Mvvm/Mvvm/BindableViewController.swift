//
//  BindableViewController.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

class BindableViewController<ViewModel: RootViewModel>: UIViewController, BindingTarget {
    
    let viewModel: ViewModel = ViewModel.init()            

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.bindingTarget = self

        viewModel.bindingDidComplete()
    }
    
    func viewModelDidUpdate(_ updatedProperty: AnyKeyPath?) { }
    
    func invokeEvent(_ event: MyEvent) {
        viewModel.handleEvent(event)
    }
}
