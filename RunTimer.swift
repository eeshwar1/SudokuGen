//
//  RunTimer.swift
//  SudokuGen
//
//  Created by Venky Venkatakrishnan on 3/4/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import CoreFoundation
import Foundation

class RunTimer {

    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?
    
    let numberFormatter: NumberFormatter

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
    }

    func stop() -> String {
        endTime = CFAbsoluteTimeGetCurrent()

        return numberFormatter.string(for: duration!) ?? "Invalid"
    }

    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
    
   
}
