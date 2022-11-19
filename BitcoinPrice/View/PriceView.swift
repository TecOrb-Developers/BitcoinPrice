//
//  ContentView.swift
//  BitcoinPrice
//
//  Created by Nakul Sharma on 19/11/22.
//

import SwiftUI

struct PriceView: View {
    @State var currentPrice: Double!
    
    @State var isLoading: Bool = true
    
    
    var body: some View {
        VStack{
            Spacer()
            //header image and text
            VStack {
                Image("header")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hey there! The current price of bitcoin is below")
                    .font(Font.custom("Mabry Pro Bold", size: 24))
                    .multilineTextAlignment(.center)
            }.padding(30)
            Spacer()
            //Price heading and the current price Label
            VStack {
                Text("Price")
                    .font(Font.custom("Mabry Pro", size: 18))
                    .multilineTextAlignment(.center).padding(5)
                let priceStr = isLoading ? "loading..." : getFormatterPrice(currentPrice)
                Text(priceStr)
                    .font(Font.custom("Mabry Pro Bold", size: 28))
                    .multilineTextAlignment(.center)
                    .onAppear(perform: loadBitcoinPrices)
            }.padding(30)
            Spacer()
            //Refresh and Loading Toggle Button
            Button(action: {
                isLoading = true
                self.loadBitcoinPrices()
            }){
                HStack{
                    Spacer()
//                    Text(isLoading ? "Loading.." : "Refresh Price")
                    Text("Refresh Price")
                        .animation(.linear(duration: 0.1))
                    Spacer()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .disabled(isLoading)
            .padding()
            .font(Font.custom("Mabry Pro Bold", size: 16))
            .foregroundColor(.white)
            .background(Color(red: 0.73, green: 0.53, blue: 1.0, opacity: isLoading ? 0.5 : 1.0))
            .cornerRadius(33)
            .shadow(color: .black.opacity(0.25), radius: 0, x: 1, y: 1)
            
            Spacer()
        }
        .padding(30)
    }
    
    func loadBitcoinPrices(){
        debugPrint("Loading Started")
        Api.loadData { resPrices in
            isLoading = false
            debugPrint("Loading completed")
            guard let resPrices = resPrices else{return}
            guard let rateFloat = resPrices.rateFloat else{return}
            DispatchQueue.main.async{
                self.currentPrice = rateFloat
            }
        }
    }
    
    //Price Formatting
    func getFormatterPrice(_ value: Double?) -> String{
        guard let value = value else{
            return "Not found!"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.currencySymbol = "$"
        let number = NSNumber(value: value)
        guard let formattedValue = formatter.string(from: number) else{return "...."}
        return "\(formattedValue)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView()
    }
}
