//
//  RunTimer.swift
//  SudokuGen
//
//  Created by Venky Venkatakrishnan on 3/4/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import CoreFoundation

class RunTimer {

    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
