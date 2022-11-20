//
//  API.swift
//  BitcoinPrice
//
//  Created by Nakul Sharma on 19/11/22.
//

import Foundation

class Api : ObservableObject{
    //@Published var bitCoinRate: BitCoinRate?
    
    static func loadData(_ completion: @escaping (BitCoinRate?) -> ()) {
        let urlStr = "https://api.coindesk.com/v1/bpi/currentprice.json"
        guard let url = URL(string: urlStr) else {
            debugPrint("Invalid url...")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                debugPrint("Not found!")
                return
            }
            if error != nil{
                debugPrint(error?.localizedDescription ?? "Something went wrong!")
                return
            }
            
            let parser = try! JSONDecoder().decode(BitCoinPriceParser.self, from: data)
            //self.bitCoinRate = parser.bpi?.USD
            completion(parser.bpi?.USD)
        }.resume()
    }
}

