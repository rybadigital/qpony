//
//  CurrencyTableViewCell.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

import UIKit

final class CurrencyTableViewCell: BindableTableViewCell<CurrencyTableViewCellModel> {
    
    @IBOutlet weak var effectiveDateLabel: UILabel!
    @IBOutlet weak var averageCourseLabel: UILabel!
        
    override func bind(source: CurrencyTableViewCellModel) {
        super.bind(source: source)
        
        effectiveDateLabel.text = source.effectiveDate
        averageCourseLabel.text = "Średni kurs: " + source.averageCourse
    }
}

final class CurrencyTableViewCellModel: GenericSectionItemViewModel {
        
    let effectiveDate: String
    let averageCourse: String
        
    init(rateResponseForCurrency: RateForCurrencyResponse) {
        self.effectiveDate = rateResponseForCurrency.effectiveDate
        self.averageCourse = NumberUtils.doubleFormatted(rateResponseForCurrency.mid)
    }
}
