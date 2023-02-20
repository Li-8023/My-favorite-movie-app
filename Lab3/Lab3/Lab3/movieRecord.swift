//
//  movieRecord.swift
//  Lab3
//
//  Created by lihe5 on 2/14/23.
//

import Foundation
class movieRecord
{
    var title:String? = nil
    var genre:String? = nil
    var price:Double? = nil
    
    init(t:String, g:String, p:Double)
    {
        self.title = t
        self.genre = g
        self.price = p
    }
    
    func change_price(newPrice:Double)
    {
        self.price = newPrice
    }
    
    func change_genre(newGenre: String)
    {
        self.genre = newGenre
    }
    
    struct movieRecord: Equatable {
        var title: String
        var genre: String
        var price: Double
        static func ==(lhs: movieRecord, rhs: movieRecord) -> Bool {
                return lhs.title == rhs.title && lhs.genre == rhs.genre && lhs.price == rhs.price
            }
    }
}
