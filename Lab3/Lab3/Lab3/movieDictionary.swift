//
//  movieDictionary.swift
//  Lab3
//
//  Created by lihe5 on 2/14/23.
//

import Foundation
import SwiftUI
class movieDictionary: ObservableObject
{
    // dictionary that stores movie records
    @Published var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    init() { }
    func add(_ title:String, _ genre:String, _ price:Double)
    {
        let mRecord =  movieRecord(t: title, g:genre, p: price)
        infoRepository[mRecord.title!] = mRecord
        for i in infoRepository {
            print(i.key)
        }
        
    }
    
    func printMovie() -> String
    {
        for i in infoRepository {
            return i.key
        }
        return ""
    }
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func getFirst() -> String
    {
        let firstKeyValuePair = infoRepository.first
        return firstKeyValuePair!.key
    }
    
    func getLast() -> String
    {
        let a = Array(infoRepository.keys)
        let last = a.last
        return last!
    }
    
    func add(m:movieRecord)
    {
        print("adding" + m.title!)
        infoRepository[m.title!] = m
        
    }
    
    func search(t:String) -> movieRecord?
    {
        var found = false
        
        for(title, _) in infoRepository
        {
            if title == t {
                found = true
                break
            }
        }
        if found{
            return infoRepository[t]
        }
        else
        {
            return nil
        }
    }
    
    func deleteRecord(t:String)
    {
        infoRepository[t] = nil
    }
    
    func getPrev(t:String) -> movieRecord?
    {

        let title = Array(infoRepository.keys) //an array contains all the key value
        for a in title {
            //if the key is the current key
            if a == t {
                if let index = title.firstIndex(where: { $0 == a})
                {
                    if index == 0
                    {
                        
                    }
                    else
                    {
                        let prevIndex = index - 1
                        let prevKey = title[prevIndex]
                        return infoRepository[prevKey]
                    }
                    
                }
            }
        }
        return nil
    }
    
    func getNext(t:String) -> movieRecord?
    {

        let title = Array(infoRepository.keys) //an array contains all the key value
        for a in title {
            //if the key is the current key
            if a == t {
                if let index = title.firstIndex(where: { $0 == a})
                {
                    if index == title.count - 1 {
                        print("It is the last record")
                        
                    }
                    else
                    {
                        let prevIndex = index + 1
                        let prevKey = title[prevIndex]
                        return infoRepository[prevKey]
                    }
                }
            }
        }
        return nil
    }
    
    func editRecord(t:String, g:String, p:String) -> movieRecord?
    {
        infoRepository[t]?.genre = g
        infoRepository[t]?.price = Double(p)
        return infoRepository[t]
    }
    
}

            
