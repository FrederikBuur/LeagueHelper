//
//  ProfileViewController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 25/10/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import SDWebImage

class ProfileViewController: UIViewController {

    private let summonerController = SummonerController()
    private let disposeBag = DisposeBag()
    private var leaguePosition: LeaguePosition? = nil
    var mSummoner: Summoner?
    

    @IBOutlet weak var summonerIconImageView: UIImageView!
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    @IBOutlet weak var summonerRankLabel: UILabel!
    @IBOutlet weak var summonerWinRatio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup summoner info
        if let sum = mSummoner, let version = RealmController.sharedInstance.getVersion()?.version {
            summonerNameLabel.text = "\(sum.name)"
            summonerLevelLabel.text = "Level: \(sum.summonerLevel)"
            let summonerIconUrl = "\(DataDragonRouter.Constants.baseUrl)/cdn/\(version)/img/profileicon/\(sum.profileIconId).png"
            print(version)
            print(summonerIconUrl)
            summonerIconImageView.sd_setImage(with: URL(string: summonerIconUrl))
            fetchLeaguePosition(id: sum.id)
        }
    }
    
    private func fetchLeaguePosition(id: Int) {
        summonerController.getLeaguePosition(id: id)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (leaguePositions) in
                    // save leaguePosition
                    self.leaguePosition = leaguePositions.filter({
                        $0.queueType == "RANKED_SOLO_5x5"
                    }).first
                    // setup league position views
                    self.setupLeaguePositionViews()
                    
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    private func setupLeaguePositionViews() {
        if let league = self.leaguePosition {
            let tier = "\(league.tier.prefix(1).capitalized)\(league.tier.dropFirst().lowercased())"
            let leageInfo = "\(tier) \(league.rank) (\(league.leaguePoints)LP)"
            let winRate = Int((Float(league.wins) / Float(league.wins + league.losses)) * 100)
            summonerRankLabel.text = leageInfo
            summonerWinRatio.text = "Win Ratio \(winRate)%"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
