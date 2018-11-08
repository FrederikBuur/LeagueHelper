//
//  ChampionsTableViewController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RealmSwift

class ChampionsTableViewController: UITableViewController {

    private var controller = DataDragonController()
    private var champions: [Champion] = []
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewestVersion()
        
        champions = RealmController.sharedInstance.getChampions().map{$0}
        self.tableView.reloadData()
        
    }
    
    private func fetchNewestVersion() {
        controller.getLatestVersion()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (latestVersion) in
                    if let version = RealmController.sharedInstance.getVersion()?.version {
                        if version.compare( latestVersion.version, options: .numeric) == .orderedAscending {
                            // newer version exist udpate champions
                            self.fetchChampions(version: version)
                        } else {
                            // champions are already up to date
                        }
                    } else {
                        self.fetchChampions(version: latestVersion.version)
                    }
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
    }
    
    private func fetchChampions(version: String) {
        controller.getChampions(version: version, in: "en_US")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (championsResponse) in
                    
                    self.champions = championsResponse.data
                    self.tableView.reloadData()
                    
                    print(championsResponse.version)
            }, onError: { (error) in
                if let v = error as? AFError {
                    if v.responseCode == 404 {
                        
                    }
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return champions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "championCell", for: indexPath) as! ChampionTableViewCell

        // Configure the cell
        cell.championName.text = champions[indexPath.row].name
        cell.championTitle.text = champions[indexPath.row].title

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
