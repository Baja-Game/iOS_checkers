//
//  GameModel.swift
//  BajaCheckers
//
//  Created by Michael McChesney on 2/19/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

private let _mainData = DataModel()

class DataModel: NSObject {
    
    var allGames: [GameModel] = []
    var currentGame: GameModel?
    
    class func mainData() -> DataModel { return _mainData }
    
}

class GameModel: NSObject {
    
    // for testing, not going in final app, but we will be using the same system for board location
    /// 0 = empty, 1 = player1, 2 = player2
    var boardSquares = [
        
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0]
        
    ]
    
    var gameID: Int?
    var lastUpdate: String?
    var turnCount: Int?
    var isFinished: Bool?
    
    // to let us know where the pieces are and where they can move
    var boardPieces: [[GamePiece?]] = Array(count: 8, repeatedValue: Array(count: 8, repeatedValue: nil))
    
    // boardSquares[row][col]    -> this is what we'll get from backend
    
    
    
    // board positions
    
    // players
    var players: [Player] = []
//    var players: [Player]?
    
    // winner
    var winner: Player?
    var isDraw = false
    
    // moves made
    
    // kings per player

    
    
}

// var oppositeRow = player.direction == 1 ? 7 : 0      // this is for kinging

class Player: NSObject {
    
    var playerID: Int?
    var playerUsername: String?
    
    
    // use direction when testing moves available
    var direction: Int!
    
    init(direction: Int) {
        
        super.init()
        self.direction = direction

    }

    
    
    
}





