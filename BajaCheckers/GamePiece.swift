//
//  GamePiece.swift
//  TryCheckers
//
//  Created by Michael McChesney on 2/18/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

/// Empty = 0, Player1 = 1, Player2 = 2, Player1King = 3, Player2King = 4
enum PieceType: Int {
    
    case Empty
    case Player1
    case Player2
    
    case Player1King
    case Player2King
    
}

protocol GamePieceDelegate {
    
    func pieceSelected(piece: GamePiece)
    
}


class GamePiece: UIView {

    var type: PieceType!
    var player: Player? {
        
        let playerIndex = (type.rawValue - 1) % 2
        
        return DataModel.mainData().currentGame?.players[playerIndex]
        
    }
    
    /// (col, row)
    var square: Square!
    
    var delegate: GamePieceDelegate?
    
    //override init
    init(type: PieceType) {
        
        super.init(frame: CGRectMake(0, 0, 20, 20))
        self.type = type
        
        // the hashValue of the enum allows for alternate coloring of pieces upon initialization
        self.backgroundColor = type.hashValue % 2 == 0 ? UIColor.cyanColor() : UIColor.magentaColor()
        self.layer.cornerRadius = 10
        
    }

    // this was to fix error. required by storyboard that it's here, but isn't what we're using.
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        // piece selected
        
        delegate?.pieceSelected(self)
        
        // change color for selection
        self.backgroundColor = UIColor.yellowColor()
        
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
