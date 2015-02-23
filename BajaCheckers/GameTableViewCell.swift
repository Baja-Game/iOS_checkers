//
//  GameTableViewCell.swift
//  BajaCheckers
//
//  Created by Michael McChesney on 2/18/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentLetterLabel: UILabel!
    @IBOutlet weak var lastMovedLabel: UILabel!
    

    var game: GameModel? {
        didSet{
            
            let currentUser = User.currentUser().username
            
            if currentUser == game?.players[0].playerUsername {
                opponentNameLabel.text = game?.players[0].playerUsername
            } else {
                opponentNameLabel.text = game?.players[1].playerUsername
            }
        
//            lastMovedLabel
            
            
            
            if let date = game?.lastUpdate {
                
                var dateFormatter = NSDateFormatter()
                // "yyyy-MM-dd-HH-mm-ss"
//                dateFormatter.dateFormat = "yyyy-MM-ddTdd:HH:mm:ss"
                var theDateFormat = NSDateFormatterStyle.ShortStyle
                dateFormatter.dateStyle = theDateFormat

                
                if let date2 = dateFormatter.dateFromString(date) {
                    lastMovedLabel.text = dateFormatter.stringFromDate(date2)
                    println(date2)
                }

            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
