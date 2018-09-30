//
//  Extensions.swift
//  WikiSearch
//
//  Created by user142467 on 9/30/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import Foundation

extension String{
    
    
    
    func formattedString()->String{
        var str = self
        str = str.replacingOccurrences(of: " ", with: "_")
        return str
        
    }
}
