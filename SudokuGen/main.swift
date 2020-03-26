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
    let square = getSquare(row: 1, col: 8, grid: Puzzles.puzzle1)
    
    print(square)
}

func getSquare(row: Int, col: Int, grid: [[Int]]) -> [[Int]]{
    
    var square: [[Int]] = []
    
    if row < 3 {
        if col < 3 {
            for i in 0...2 {
                square.append(Array(grid[i][0...2]))
            }
        }
        else {
            if col < 6 {
                for i in 0...2 {
                    square.append(Array(grid[i][3...5]))
                }
            }
            else
            {
                for i in 0...2 {
                    square.append(Array(grid[i][6...8]))
                }
            }
        }
    }
    else
    {
        if row < 6 {
            if col < 3 {
                       for i in 3...5 {
                           square.append(Array(grid[i][0...2]))
                       }
                   }
            else {
                       if col < 6 {
                           for i in 3...5 {
                               square.append(Array(grid[i][3...5]))
                           }
                       }
            else
                       {
                        for i in 3...5 {
                               square.append(Array(grid[i][6...8]))
                           }
                       }
                   }
        }
        else {
            
            if col < 3 {
                                  for i in 6...8 {
                              square.append(Array(grid[i][0...2]))
                          }
                      }
               else {
                          if col < 6 {
                              for i in 6...8 {
                                  square.append(Array(grid[i][3...5]))
                              }
                          }
               else
                          {
                           for i in 6...8 {
                                  square.append(Array(grid[i][6...8]))
                              }
                          }
                      }
    
        }
    }
    
    return square
}
class Puzzle {

    let dimension = 9
 
    var grid: [[Int]] = []
    var numberList = [1,2,3,4,5,6,7,8,9]
    
    var counter = 1
    
    func createPuzzle() -> (puzzle: [[Int]], solution: [[Int]])
    {
        grid = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
        
        let _ = fillGrid()
        
        let solutionGrid = self.grid
        
        let _ = generatePuzzle()
        
        let puzzleGrid = self.grid
        
        return (puzzleGrid,solutionGrid)
    }
    
    func checkGrid() -> Bool {
           
           for row in 0...8 {
               for col in 0...8 {
                   if self.grid[row][col] == 0 {
                       
                   
                       VUDebug.print(message: "checkGrid: returning false", level: .info)
                   
                       return false
                   }
               }
           }
        
           VUDebug.print(message: "checkGrid: returning true", level: .info)
           
           return true
           
    }

    func fillGrid() -> Bool {
        
        for num in 0...80 {
            
            
            let row = num / 9
            let col = num % 9
            
          
            VUDebug.print(message: "num: \(num) row: \(row) col: \(col)", level: .info)
  
            if self.grid[row][col] == 0 {
                
                self.numberList.shuffle()
                for value in numberList {
                    
                    let gridRow = grid[row]
                    var gridCol: [Int] = []
                    
                    for rowNum in 0...8 {
                        gridCol.append(self.grid[rowNum][col])
                    }
                
                    VUDebug.print(message: "gridRow: \(gridRow)", level: .info)
                    VUDebug.print(message: "gridCol: \(gridCol)", level: .info)
                
                    // Identify which of the 9 squares we are working on
                    
                    let square = getSquare(row: row, col: col, grid: grid)
        
                    if !gridRow.contains(value)   &&
                       !gridCol.contains(value)   &&
                       !square[0].contains(value) &&
                       !square[1].contains(value) &&
                       !square[2].contains(value ){
                        self.grid[row][col] = value
                        if checkGrid()
                        {
                          
                            VUDebug.print(message: "fillGrid: returning true - checkGrid", level: .info)
                            
                           return true
                        }
                        else {
                          if fillGrid() {
                            
                        
                            VUDebug.print(message: "fillGrid: returning true - fillGrid", level: .info)
                            
                               return true
                           }
                        
                        }
                    }
                    
                }
                self.grid[row][col] = 0
                return false
             
            }
            
            
            
        }
        
        
        VUDebug.print(message: "fillGrid: returning false", level: .info)
        return false
        
    
    }
    
    func solveGrid() -> Bool {
    
        for num in 0...80 {
            
            
            let row = num / 9
            let col = num % 9
            
          
            VUDebug.print(message: "num: \(num) row: \(row) col: \(col)", level: .info)
            
         
            if self.grid[row][col] == 0 {
                
                self.numberList.shuffle()
                for value in numberList {
                    
                    let gridRow = grid[row]
                    var gridCol: [Int] = []
                    
                    for rowNum in 0...8 {
                        gridCol.append(self.grid[rowNum][col])
                    }
                
                    VUDebug.print(message: "gridRow: \(gridRow)", level: .info)
                    VUDebug.print(message: "gridCol: \(gridCol)", level: .info)
                
                    // Identify which of the 9 squares we are working on
                    
                    let square = getSquare(row: row, col: col, grid: grid)
        
                    if !gridRow.contains(value)   &&
                       !gridCol.contains(value)   &&
                       !square[0].contains(value) &&
                       !square[1].contains(value) &&
                       !square[2].contains(value ){
                        self.grid[row][col] = value
                        if checkGrid()
                        {
                          
                            VUDebug.print(message: "solveGrid: break - checkGrid", level: .info)
                            counter = counter + 1
                            break
                        }
                        else {
                          if solveGrid() {
                            
                        
                            VUDebug.print(message: "solveGrid: returning true - solveGrid", level: .info)
                            
                               return true
                           }
                        
                        }
                    }
                    
                }
                self.grid[row][col] = 0
                return false
             
            }
            

        }
        
        VUDebug.print(message: "solveGrid: returning false", level: .info)
        return false
    }
    
    func generatePuzzle() -> [[Int]] {
        
        var attempts = 5
        
        
        while attempts > 0 {
            
            var row = Int.random(in: 0...8)
            var col = Int.random(in: 0...8)
            
            while self.grid[row][col] == 0 {
                row = Int.random(in: 0...8)
                col = Int.random(in: 0...8)
            }
            
            let backupValue = self.grid[row][col]
            self.grid[row][col] = 0
     
            var copyGrid: [[Int]] = []
            for i in 0...8 {
                copyGrid.append(self.grid[i])
            }
            
            counter  = 0
            let _ = solveGrid()
            if counter != 1 {
                self.grid[row][col] = backupValue
                attempts = attempts - 1
            }
        }
        return self.grid
    }
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




