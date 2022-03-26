//
//  QuoteData.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 16.10.2021.
//

import Foundation

struct MainData : Codable{
    let data:QuoteData
}

struct QuoteData : Codable {
    var author:String
    var quote:String
}
