//
//  MusicSearchTableViewCell.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/18/22.
//

import UIKit

class MusicSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var musicSearchImage: UIImageView!
    @IBOutlet weak var musicSearchSongName: UILabel!
    @IBOutlet weak var musicSearchArtistName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
