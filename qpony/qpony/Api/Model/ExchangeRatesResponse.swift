//
//  ExchangeRatesResponse.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import Foundation

struct ExchangeRatesResponse: Codable {

    let table: String
    let no: String
    let effectiveDate: String
    let rates: [RateResponse]
    
    let tradingDate: String?
}
