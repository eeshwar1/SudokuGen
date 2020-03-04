//
//  VUDebug.swift
//  SudokuGen
//
//  Created by Venky Venkatakrishnan on 3/3/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation


enum MessageType: Int {
    
    case info = 0
    case warn = 1
    case error = 2
}
enum DEBUG_LEVEL: Int {
    case all = 0
    case none = 9
    case some = 1
}

class VUDebug {
    
    static var debugLevel: DEBUG_LEVEL = .all
    
    static func print(message: String, level: MessageType) {
        
        if level.rawValue >= debugLevel.rawValue {
            Swift.print(message)
        }
        
    }
}
