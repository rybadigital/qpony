//
//  CurrencyViewModel.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

import UIKit

final class CurrencyViewModel: RootViewModel {
    
    enum Events: MyEvent {
        case changeDateFrom(date: Date)
        case changeDateTo(date: Date)
        case refresh
    }
    
    var currency: String = ""
    var table: String = ""
    var code: String = ""
    
    var title: String {
        return "\(currency)(\(code))"
    }
    
    var dateFrom: Date = Date()
    var dateTo: Date = Date()
        
    var cellsVM: [CurrencyTableViewCellModel] = [] {
        didSet {
            viewModelDidUpdate(\CurrencyViewModel.cellsVM)
        }
    }
       
    override func bindingDidComplete() {
        super.bindingDidComplete()
        
        refresh()
    }
        
    override func handleEvent(_ event: MyEvent) {
        super.handleEvent(event)
        
        switch event {
        case Events.changeDateFrom(let date):
            dateFrom = date
            refresh()
        case Events.changeDateTo(let date):
            dateTo = date
            refresh()
        case Events.refresh:
            refresh()
        default:
            break
        }
    }    
    
    private func refresh() {
        let dateFromString = DateUtils.formatDateToString(date: dateFrom)
        let dateToString = DateUtils.formatDateToString(date: dateTo)
        
        ApiRequest.getExchangeRatesForCurrency(table: table, code: code, dateFrom: dateFromString, dateTo: dateToString, completion: { response in
            var cells: [CurrencyTableViewCellModel] = []
          
            for rate in response.rates {
                let cellVM = CurrencyTableViewCellModel(rateResponseForCurrency: rate)

                cells.append(cellVM)
            }

            DispatchQueue.main.async {
                self.cellsVM = cells
            }
        }, err: { () in
            DispatchQueue.main.async {
                self.cellsVM = []
            }                        
        })
    }
}
