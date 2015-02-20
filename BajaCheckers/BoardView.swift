//
//  BoardView.swift
//  BajaCheckers
//
//  Created by Michael McChesney on 2/18/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
// 

import UIKit

@IBDesignable class BoardView: UIView, GamePieceDelegate {
    
    let gridSize = 8
    
    override func layoutSubviews() {
        
        if let boardSquares = DataModel.mainData().currentGame?.boardSquares {
            
            // make pieces based on boardSquares array
            for (rowIndex, rowArray) in enumerate(boardSquares) {
                
                for (columnIndex, squarePieceType) in enumerate(rowArray) {
                    
                    if squarePieceType == 0 { continue }
                    
                    if let type = PieceType(rawValue: squarePieceType) {
                        
                        var piece = GamePiece(type: type)
                        piece.delegate = self
                        
                        // tell each piece its current position
                        piece.square = (columnIndex, rowIndex)
                        
                        DataModel.mainData().currentGame?.boardPieces[rowIndex][columnIndex] = piece
                        
                        // pasted this from the part making the board below
                        let cF = CGFloat(columnIndex)
                        let rF = CGFloat(rowIndex)
                        
                        let squareSize = frame.width / CGFloat(gridSize)
                        
                        let x = cF * squareSize + squareSize / 2
                        let y = rF * squareSize + squareSize / 2
                        
                        piece.center = CGPointMake(x, y)
                        
                        addSubview(piece)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func pieceSelected(piece: GamePiece) {
        
        // piece.square is starting point (so +/- 1 to check other positions in array for nil)
        let (c,r) = piece.square
        
        // TO DO
        if piece.player?.direction == 1 {
            let squareTopRight = DataModel.mainData().currentGame?.boardPieces[c + 1][r - 1]
            let squareTopLeft = DataModel.mainData().currentGame?.boardPieces[c - 1][r - 1]
        } else {
            let squareBottomRight = DataModel.mainData().currentGame?.boardPieces[c + 1][r + 1]
            let squareBottomLeft = DataModel.mainData().currentGame?.boardPieces[c - 1][r + 1]
        }

        
        // do something with piece
        

        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // square selected. this should only do something if you have a selected piece...
        
        if let touch = touches.allObjects.last as? UITouch {
            
            let location = touch.locationInView(self)
            
            let squareSize = frame.width / CGFloat(gridSize)
            
            // find position in the grid
            let col = Int(floor(location.x / squareSize))
            let row = Int(floor(location.y / squareSize))
            
            if let selectedSquare = DataModel.mainData().currentGame?.boardPieces[row][col] {

                // check for possible moves
                pieceSelected(selectedSquare)
                
            }

        }
        
    }
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // loop through cols
        for c in 0..<gridSize {
            
            
            // loop through rows
            for r in 0..<gridSize {
                
                let cF = CGFloat(c)
                let rF = CGFloat(r)
                
                let squareSize = rect.width / CGFloat(gridSize)
                
                let x = cF * squareSize
                let y = rF * squareSize
                
                let color = (c + r) % 2 == 0 ? UIColor.lightGrayColor() : UIColor.darkGrayColor()
                
                color.set()
                
                CGContextFillRect(ctx, CGRectMake(x, y, squareSize, squareSize))
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
}
