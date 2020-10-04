//
//  MainScreenViewController.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

final class MainScreenViewController: BindableViewController<MainScreenViewModel> {    
    
    @IBOutlet weak var tableTypeSegmentedControl: UISegmentedControl!
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
        case \MainScreenViewModel.cellsVM:
            refresh()
        case \MainScreenViewModel.errorAlert:
            let alert = viewModel.errorAlert
            
            navigationController?.present(alert, animated: true, completion: nil)            
        default:
            break
        }
    }
    
    // MARK: - private methods
    private func setUpView() {
        title = "Ekran walut"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(type: MainScreenTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
 
    private func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        tableTypeSegmentedControl.isUserInteractionEnabled = true
    }
    
    @objc
    private func pullToRefresh(_ sender: Any) {
        invokeEvent(MainScreenViewModel.Events.refresh)
        tableTypeSegmentedControl.isUserInteractionEnabled = false
    }
    
    @IBAction func didChangeType(_ sender: Any) {
        let selectIndex = tableTypeSegmentedControl.selectedSegmentIndex
        invokeEvent(MainScreenViewModel.Events.changeTypeTable(index: selectIndex))
        activityIndicator.startAnimating()
        tableView.isHidden = true
        tableTypeSegmentedControl.isUserInteractionEnabled = false
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueBindableCell(for: indexPath, in: viewModel.cellsVM, eventHandler: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = CurrencyViewController()
        vc.viewModel.table = viewModel.selectTableType.rawValue
        vc.viewModel.code = viewModel.cellsVM[indexPath.row].code
        vc.viewModel.currency = viewModel.cellsVM[indexPath.row].currency
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
