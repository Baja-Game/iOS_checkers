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
    
    var player2: String?
    var lastUpdated: String?
    var turnCount: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
