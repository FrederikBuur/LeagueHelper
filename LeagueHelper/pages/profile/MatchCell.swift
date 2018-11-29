//
//  MatchCell.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 29/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet weak var championImage: UIImageView!
    @IBOutlet weak var summonerSpell1Image: UIImageView!
    @IBOutlet weak var summonerSpell2Image: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //private var participant: Participant? = nil
    
    func setupCell(match: Match, version: String?, summonerId: CLong?) {
        if let v = version, let id = summonerId {
            match.participantIdentities.forEach { (pi) in
                
                // participant identity found
                if pi.player.summonerId == id {
                    match.participants.forEach({ (p) in
                        
                        // participant found
                        if p.id == pi.participantId {
                            setScore(ps: p.stats)
                            setResult(ps: p.stats)
                            setImages(participant: p, version: v)
                        }
                    })
                }
            }
        }
    }
    
    private func setImages(participant: Participant, version: String) {
        
        // setting champion image
        let champion = RealmController.sharedInstance.getChampionById(id: participant.championId)
        if let img = champion?.image?.full {
            let url = DataDragonRouter.getChampionImagePath(version: version, imgName: img)
            self.championImage.sd_setImage(with: URL(string: url))
        }
        
        // setting summonerspell images
        let summonerSpell1 = RealmController.sharedInstance.getSummonerSpellById(id: participant.spell1Id)
        let summonerSpell2 = RealmController.sharedInstance.getSummonerSpellById(id: participant.spell2Id)
        if let ss1 = summonerSpell1?.image?.full, let ss2 = summonerSpell2?.image?.full {
            let url1 = DataDragonRouter.getSummonerSpellImagePath(version: version, imgName: ss1)
            let url2 = DataDragonRouter.getSummonerSpellImagePath(version: version, imgName: ss2)
            self.summonerSpell1Image.sd_setImage(with: URL(string: url1))
            self.summonerSpell2Image.sd_setImage(with: URL(string: url2))
        }
        
    }
    
    private func setResult(ps: ParticipantStats) {
        if ps.win {
            resultLabel.text = "Win"
            resultLabel.textColor = UIColor.green
        } else {
            resultLabel.text = "Loss"
            resultLabel.textColor = UIColor.red
        }
    }
    
    private func setScore(ps: ParticipantStats) {
        scoreLabel.text = "\(ps.kills)/\(ps.deaths)/\(ps.assists)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
