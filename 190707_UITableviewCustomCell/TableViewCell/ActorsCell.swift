//
//  ActorsCell.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 27/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit

class ActorsCell: UITableViewCell {

    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLbl: UILabel!
    @IBOutlet weak var actorAgeLbl: UILabel!
    @IBOutlet weak var actorMobileLbl: UILabel!
    
    
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
        actorImage.layer.cornerRadius = actorImage.frame.size.width / 2
        actorImage.clipsToBounds = true
        actorImage.layer.borderWidth = 1

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
