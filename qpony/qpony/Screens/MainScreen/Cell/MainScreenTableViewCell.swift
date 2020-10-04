//
//  MainScreenTableViewCell.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

final class MainScreenTableViewCell: BindableTableViewCell<MainScreenTableViewCellModel> {
    
    @IBOutlet weak var effectiveDateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var averageCourseLabel: UILabel!
        
    override func bind(source: MainScreenTableViewCellModel) {
        super.bind(source: source)
        
        effectiveDateLabel.text = source.effectiveDate
        currencyLabel.text = source.currency
        codeLabel.text = source.code
        averageCourseLabel.text = "Średni kurs: " + source.averageCourse
    }
}

final class MainScreenTableViewCellModel: GenericSectionItemViewModel {
        
    let effectiveDate: String
    let currency: String
    let code: String
    let averageCourse: String
        
    init(rateResponse: RateResponse, effectiveDate: String) {
        self.effectiveDate = effectiveDate
        self.currency = rateResponse.currency
        self.code = rateResponse.code
        self.averageCourse = NumberUtils.doubleFormatted(rateResponse.mid)
    }
}

class GenericSectionItemViewModel: BaseViewModel, IdentifiableObject { }
