//
//  BitcoinPrices.swift
//  BitcoinPrice
//
//  Created by Nakul Sharma on 19/11/22.
//

import Foundation

struct BitCoinPriceParser: Codable {
    
    let time: Time?
    let disclaimer: String?
    let chartName: String?
    let bpi: Bpi?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time = try values.decodeIfPresent(Time.self, forKey: .time)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        chartName = try values.decodeIfPresent(String.self, forKey: .chartName)
        bpi = try values.decodeIfPresent(Bpi.self, forKey: .bpi)
    }
    
    private enum CodingKeys: String, CodingKey {
        case time = "time"
        case disclaimer = "disclaimer"
        case chartName = "chartName"
        case bpi = "bpi"
    }
    
    
}

struct Time: Codable {
    
    let updated: String?
    let updatedISO: String?
    let updateduk: String?
    
    private enum CodingKeys: String, CodingKey {
        case updated = "updated"
        case updatedISO = "updatedISO"
        case updateduk = "updateduk"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        updatedISO = try values.decodeIfPresent(String.self, forKey: .updatedISO)
        updateduk = try values.decodeIfPresent(String.self, forKey: .updateduk)
    }
    
}

struct Bpi: Codable {
    
    let USD: BitCoinRate?
    let GBP: BitCoinRate?
    let EUR: BitCoinRate?
    
    private enum CodingKeys: String, CodingKey {
        case USD = "USD"
        case GBP = "GBP"
        case EUR = "EUR"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        USD = try values.decodeIfPresent(BitCoinRate.self, forKey: .USD)
        GBP = try values.decodeIfPresent(BitCoinRate.self, forKey: .GBP)
        EUR = try values.decodeIfPresent(BitCoinRate.self, forKey: .EUR)
    }
}

struct BitCoinRate: Codable {
    var code: String?
    var symbol: String?
    var rate: String?
    var description: String?
    var rateFloat: Double?
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rateFloat = "rate_float"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        rateFloat = try values.decodeIfPresent(Double.self, forKey: .rateFloat)
    }
    
}

//let parser = BitCoinPriceParser(from: <#Decoder#>)
//let priceToBeShown = parser.bpi?.USD?.rateFloat



/**
 {
 "time": {
 "updated": "Nov 19, 2022 10:30:00 UTC",
 "updatedISO": "2022-11-19T10:30:00+00:00",
 "updateduk": "Nov 19, 2022 at 10:30 GMT"
 },
 "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
 "chartName": "Bitcoin",
 "bpi": {
 "USD": {
 "code": "USD",
 "symbol": "&#36;",
 "rate": "16,618.8359",
 "description": "United States Dollar",
 "rate_float": 16618.8359
 },
 "GBP": {
 "code": "GBP",
 "symbol": "&pound;",
 "rate": "13,886.5663",
 "description": "British Pound Sterling",
 "rate_float": 13886.5663
 },
 "EUR": {
 "code": "EUR",
 "symbol": "&euro;",
 "rate": "16,189.1725",
 "description": "Euro",
 "rate_float": 16189.1725
 }
 }
 }
 
 
 */
