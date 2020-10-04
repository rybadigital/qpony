//
//  ExchangeRatesForCurrencyResponse.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

import Foundation

struct ExchangeRatesForCurrencyResponse: Codable {

    let table: String
    let currency: String
    let code: String            
    let rates: [RateForCurrencyResponse]
        
}
