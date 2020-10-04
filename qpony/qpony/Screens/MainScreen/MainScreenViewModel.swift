//
//  MainScreenViewModel.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

final class MainScreenViewModel: RootViewModel {
    
    enum Events: MyEvent {
        case changeTypeTable(index: Int)
        case refresh
    }
    
    var selectTableType: TableTypes = .A
    
    var cellsVM: [MainScreenTableViewCellModel] = [] {
        didSet {
            viewModelDidUpdate(\MainScreenViewModel.cellsVM)
        }
    }
    
    var errorAlert: UIAlertController {
        let alert = UIAlertController(title: "Błąd", message: "Coś poszło nie tak", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        return alert
    }
    
    override func bindingDidComplete() {
        super.bindingDidComplete()
        
        refreshTable()
    }
        
    override func handleEvent(_ event: MyEvent) {
        super.handleEvent(event)
        
        switch event {
        case Events.changeTypeTable(let index):
            changeTableType(index: index)
        case Events.refresh:
            refreshTable()
        default:
            break
        }
    }
    
    private func changeTableType(index: Int) {
        switch index {
        case 0:
            selectTableType = .A
        case 1:
            selectTableType = .B
        case 2:
            selectTableType = .C
        default:
            break
        }
        
        refreshTable()
    }
    
    private func refreshTable() {
        ApiRequest.getExchangeRates(table: selectTableType.rawValue, completion: { response in
            var cells: [MainScreenTableViewCellModel] = []
            guard let data = response.first else {
                return
            }
            
            for rate in data.rates {
                let cellVM = MainScreenTableViewCellModel(rateResponse: rate, effectiveDate: data.effectiveDate)
                
                cells.append(cellVM)
            }
            
            DispatchQueue.main.async {
                self.cellsVM = cells
            }
        }, err: { () in
            DispatchQueue.main.async {
                self.cellsVM = []
                self.viewModelDidUpdate(\MainScreenViewModel.errorAlert)
            }
        })
    }
}

enum TableTypes: String {

    case A
    case B
    case C
}
