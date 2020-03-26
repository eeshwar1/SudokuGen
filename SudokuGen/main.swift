//
//  main.swift
//  SudokuGen
//
//  Created by Venky Venkatakrishnan on 3/2/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation

VUDebug.debugLevel = .some

struct Puzzles {
    static let puzzle1 =  [[5,3,0,0,7,0,0,0,0],
                           [6,0,0,1,9,5,0,0,0],
                           [0,9,8,0,0,0,0,6,0],
                           [8,0,0,0,6,0,0,0,3],
                           [4,0,0,8,0,3,0,0,1],
                           [7,0,0,0,2,0,0,0,6],
                           [0,6,0,0,0,0,2,8,0],
                           [0,0,0,4,1,9,0,0,5],
                           [0,0,0,0,8,0,0,7,9]]
    
    
}

func testSquare()
{
    let square = Puzzle().getSquare(row: 1, col: 8, grid: Puzzles.puzzle1)
    
    print(square)
}


print("Creating Puzzle...")



//var runLoop: RunLoop


//runLoop = RunLoop.current

var puzzles: [(puzzle: [[Int]],solution: [[Int]])] = []

/*
func puzzleGen(name: String) {
    
    let puzzle = Puzzle()
    let runTimer = RunTimer()
    
    //var grid: [[Int]] = []
    var puzzleGrid: [[Int]] = []
    
    DispatchQueue.global(qos: .userInitiated).async {
            
            print("running...")
            (_, puzzleGrid) =  puzzle.createPuzzle()
            
            DispatchQueue.main.async {

                print("\(name): Done in \(runTimer.stop()) seconds")
                //print(grid)
                puzzles.append(puzzleGrid)
                
                print("Complete")
                
                
                
                
            }
            
        }
        print("Still working...")
        

}



autoreleasepool(invoking: {
    
    puzzleGen(name: "puzzle1")
    
    runLoop.run(mode: .default, before: .distantFuture)
    
})

autoreleasepool(invoking: {
    
    puzzleGen(name: "puzzle2")

    runLoop.run(mode: .default, before: .distantFuture)
    
})

 */


func generatePuzzle(name: String) -> ([[Int]], [[Int]]) {
    
    print("\(name): generating puzzle...")
    let puzzle = Puzzle()
    let runTimer = RunTimer()
    
    var solutionGrid : [[Int]] = []
    var puzzleGrid : [[Int]] = []
    (puzzle: puzzleGrid, solutionGrid) = puzzle.createPuzzle()
    
    /*DispatchQueue.main.async {

        
        print("\(name): Done in \(runTimer.stop()) seconds")
        //print(grid)
        puzzles.append(puzzleGrid)
    
                  
    }*/
    
    print("\(name): Done in \(runTimer.stop()) seconds")
    return (puzzleGrid, solutionGrid)

}

let group = DispatchGroup()
let queue = DispatchQueue(label: "", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)


for i in 1...5 {
    
    print("Loop \(i)")
    queue.async(group: group, execute: DispatchWorkItem() {
        
        puzzles.append(generatePuzzle(name: "Puzzle \(i)"))
    })
}

_ = group.wait(timeout: .distantFuture)

print("Main Thread \(puzzles)")




