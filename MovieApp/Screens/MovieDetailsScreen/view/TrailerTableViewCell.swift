//
//  TrailerTableViewCell.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/15/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeImgView: UIImageView!
    @IBOutlet weak var trailerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
