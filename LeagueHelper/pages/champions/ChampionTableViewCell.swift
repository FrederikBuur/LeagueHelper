//
//  ChampionTableViewCell.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {

    @IBOutlet weak var championImage: UIImageView!
    @IBOutlet weak var championName: UILabel!
    @IBOutlet weak var championTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(champion: Champion, version: String?) {
        self.championName.text = champion.name
        self.championTitle.text = champion.title
        if let image = champion.image?.full, let version = version {
            let url = DataDragonRouter.getChampionImagePath(version: version, imgName: image)
            self.championImage.sd_setImage(with: URL(string: url))
            self.championImage.layer.cornerRadius = self.championImage.frame.width / 2
            self.championImage.layer.borderWidth = 1.0
            self.championImage.layer.borderColor = UIColor.black.cgColor
            self.championImage.clipsToBounds = true
        }
    }

}
