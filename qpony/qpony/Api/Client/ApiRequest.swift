//
//  ApiRequest.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

final class ApiRequest {
    
    static let baseURL = "http://api.nbp.pl/api/"
    
    static func getExchangeRates(table: String, completion: @escaping ([ExchangeRatesResponse]) -> (), err: @escaping () -> ()) {
        let endpoint = "exchangerates/tables/\(table)"
        let urlString = baseURL + endpoint
        
        print(urlString)
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, res, error in
                guard error == nil else {
                    err()
                    
                    return
                }
                             
                guard let responseData = data,
                    let httpResponse = res as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode else {
                    err()
                    return
                }
                                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode([ExchangeRatesResponse].self, from: responseData) {
                    completion(json)
                } else {
                    err()
                }
            }.resume()
        }
    }
    
    static func getExchangeRatesForCurrency(table: String, code: String, dateFrom: String? = nil, dateTo: String? = nil, completion: @escaping (ExchangeRatesForCurrencyResponse) -> (), err: @escaping () -> ()) {
        var endpoint = "exchangerates/rates/\(table)/\(code)"
        
        if let dateFrom = dateFrom {
            endpoint += "/\(dateFrom)"
            
            if let dateTo = dateTo {
                endpoint += "/\(dateTo)"
            }
        }
        
        let urlString = baseURL + endpoint
        
        print(urlString)
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, res, error in
                guard error == nil else {
                    err()
                    
                    return
                }
                             
                guard let responseData = data,
                    let httpResponse = res as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode else {
                    err()
                    return
                }
                                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(ExchangeRatesForCurrencyResponse.self, from: responseData) {
                    completion(json)
                } else {
                    err()
                }
                
            }.resume()
        }
    }
}
