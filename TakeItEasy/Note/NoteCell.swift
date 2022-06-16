//
//  NoteCell.swift
//  TakeItEasy
//
//  Created by Mihir Ghosh on 6/15/22.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDesc: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

