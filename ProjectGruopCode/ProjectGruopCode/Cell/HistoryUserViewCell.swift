//
//  HistoryUserViewCell.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/10/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit

class HistoryUserViewCell: UITableViewCell {

 
    @IBOutlet weak var txtScore: UILabel!
    @IBOutlet weak var txtTimeComplete: UILabel!
    @IBOutlet weak var txtTimeTest: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
