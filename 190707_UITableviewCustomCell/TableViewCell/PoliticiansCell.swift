//
//  PoliticiansCell.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 27/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit

class PoliticiansCell: UITableViewCell {

    @IBOutlet weak var politicianImage: UIImageView!
    @IBOutlet weak var politicianNameLbl: UILabel!
    @IBOutlet weak var politicianAgeLbl: UILabel!
    @IBOutlet weak var politicianMobileLbl: UILabel!
    
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
        
        politicianImage.layer.cornerRadius = politicianImage.frame.size.width / 2
        politicianImage.clipsToBounds = true
        politicianImage.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
