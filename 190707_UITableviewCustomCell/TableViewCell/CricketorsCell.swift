//
//  CricketorsCell.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 27/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit

class CricketorsCell: UITableViewCell {

    
    @IBOutlet weak var cricketorImage: UIImageView!
    @IBOutlet weak var cricketorNameLbl: UILabel!
    @IBOutlet weak var cricketorAge: UILabel!
    @IBOutlet weak var cricketorMobileLbl: UILabel!
    
    @IBAction func likeActionBtn(_ sender: UIButton) {
        sender.pulseButton()
    }
    
    @IBAction func commentActionBtn(_ sender: UIButton) {
        sender.pulseButton()
    }
    
    @IBAction func shareActionBtn(_ sender: UIButton) {
        sender.pulseButton()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cricketorImage.layer.cornerRadius = cricketorImage.frame.size.width / 2
        cricketorImage.clipsToBounds = true
        cricketorImage.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
