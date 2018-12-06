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
    private var version: String? = nil
    private var matches: [Match] = []
    
    var mSummoner: Summoner?

    @IBOutlet weak var summonerIconImageView: UIImageView!
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    @IBOutlet weak var summonerRankLabel: UILabel!
    @IBOutlet weak var summonerWinRatio: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup summoner info
        if let sum = mSummoner, let version = RealmController.sharedInstance.getVersion()?.version {
            self.version = version
            summonerNameLabel.text = "\(sum.name)"
            summonerLevelLabel.text = "Level: \(sum.summonerLevel)"
            let summonerIconUrl = DataDragonRouter.getSummonerIconImagePath(version: version, imgName: sum.profileIconId)
            print(summonerIconUrl)
            summonerIconImageView.sd_setImage(with: URL(string: summonerIconUrl))
            fetchLeaguePosition(id: sum.id)
            fetchMatches(summonerId: sum.accountId)
        }
    }
    
    private func fetchMatches(summonerId: Int) {
        summonerController.getLatestMatches(id: summonerId, beginIndex: 0, endIndex: 20)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .concatMap { (matchList) in
                return Observable.from(matchList.matches)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.instance)
                    .concatMap { (matchReference) in
                        return self.summonerController.getMatch(id: matchReference.gameId)
                    }
                    .do(onNext: { (match) in
                        self.matches.append(match)
                        self.tableView.reloadData()
                    }, onError: { (error) in
                    }, onCompleted: {
                        self.tableView.reloadData()
                    })
            }
            .subscribe()
            .disposed(by: disposeBag)
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchCell
        
        let match = self.matches[indexPath.row]
        cell.setupCell(match: match, version: self.version, summonerId: self.mSummoner?.id)
        
        
        return cell
    }
    
}
