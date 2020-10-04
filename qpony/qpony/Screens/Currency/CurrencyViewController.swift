//
//  CurrencyViewController.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

import UIKit

final class CurrencyViewController: BindableViewController<CurrencyViewModel> {
    
    @IBOutlet weak var dateFromDatePicker: UIDatePicker!
    @IBOutlet weak var dateToDatePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpView()
    }
    
    override func viewModelDidUpdate(_ updatedProperty: AnyKeyPath?) {
        super.viewModelDidUpdate(updatedProperty)
        
        switch updatedProperty {
        case \CurrencyViewModel.cellsVM:
            refresh()
        default:
            break
        }
    }
    
    // MARK: - private methods
    private func setUpView() {
        title = viewModel.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(type: CurrencyTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        dateFromDatePicker.maximumDate = Date()
        dateToDatePicker.maximumDate = Date()        
    }
        
    @objc
    private func pullToRefresh(_ sender: Any) {
        invokeEvent(CurrencyViewModel.Events.refresh)
    }
 
    private func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
        
    @IBAction func didDateFromChanged(_ sender: Any) {
        invokeEvent(CurrencyViewModel.Events.changeDateFrom(date: dateFromDatePicker.date))
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    @IBAction func didDateToChanged(_ sender: Any) {
        invokeEvent(CurrencyViewModel.Events.changeDateTo(date: dateToDatePicker.date))
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueBindableCell(for: indexPath, in: viewModel.cellsVM, eventHandler: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
