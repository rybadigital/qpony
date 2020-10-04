//
//  RateForCurrencyResponse.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

struct RateForCurrencyResponse: Codable {
    
    let no: String
    let effectiveDate: String
        
    let mid: Double?
    let bid: Double?
    let ask: Double?
}
