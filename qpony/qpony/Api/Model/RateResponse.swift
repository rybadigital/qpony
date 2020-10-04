//
//  RateResponse.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

struct RateResponse: Codable {
    
    let currency: String
    let code: String
        
    let mid: Double?
    let bid: Double?
    let ask: Double?
}
