//
//  BitcoinPriceApp.swift
//  BitcoinPrice
//
//  Created by Nakul Sharma on 19/11/22.
//

import SwiftUI

@main
struct BitcoinPriceApp: App {
    var body: some Scene {
        WindowGroup {
            PriceView()
                .background(Color(red: 0.93, green: 0.89, blue: 1.0, opacity: 1.0))
        }
    }
}
