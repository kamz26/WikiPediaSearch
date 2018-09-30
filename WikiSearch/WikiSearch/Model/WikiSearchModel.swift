//
//  WikiSearchModel.swift
//  WikiSearch
//
//  Created by user142467 on 9/30/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import Foundation

class WikiSearchData:Codable{
    var batchcomplete:Bool?
    var query:Query?
    
    
}

class Query:Codable{
    var redirects:[Redirect]?
    var pages:[Page]?
    
}
class Redirect:Codable{
    
}
class Page:Codable{
    
    var pageid:Int64?
    var ns:Int?
    var title : String?
    var index:Int?
    var thumbnail:Thumbnail?
    var terms:Term?
    
    
    
}
class Term:Codable{
    
    var description:[String]?
    
}
class Thumbnail:Codable{
    var source : String?
    var width:Int?
    var height:Int?
    
}
