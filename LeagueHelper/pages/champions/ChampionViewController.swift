//
//  ChampionViewController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 15/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionViewController: UIViewController {

    var champion: Champion? = nil
    
    @IBOutlet weak var championImage: UIImageView!
    @IBOutlet weak var championName: UILabel!
    @IBOutlet weak var championTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        if let champion = self.champion {
            championName.text = champion.name
            championTitle.text = champion.title
            let url = "\(DataDragonRouter.Constants.baseUrl)/cdn/img/champion/splash/\(champion.id)_0.jpg"
            championImage.sd_setImage(with: URL(string: url))
        }
    }
}
