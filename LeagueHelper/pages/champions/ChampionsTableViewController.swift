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
import SDWebImage

class ChampionsTableViewController: UITableViewController, UISearchBarDelegate {

    private var controller = DataDragonController()
    private var champions: [Champion] = []
    private var searchChampions: [Champion] = []
    private var isSearching = false
    private var version: String? = nil
    private var selectedChampion: Champion? = nil
    private let disposeBag = DisposeBag()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        fetchNewestVersion()
        version = RealmController.sharedInstance.getVersion()?.version
        champions = RealmController.sharedInstance.getChampions().map{$0}
        searchChampions = champions
        self.tableView.reloadData()
        print("show champions from realm")
    }
    
    private func createSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search champion..."
        searchBar.delegate = self
        searchBar.resignFirstResponder()
        self.navigationItem.titleView = searchBar
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
                            print("newer version exist, fetch new champions")
                            self.version = version
                            self.fetchChampions(version: version)
                        } else {
                            // champions are already up to date
                            print("champions already up to date")
                        }
                    } else {
                        self.version = latestVersion.version
                        self.fetchChampions(version: latestVersion.version)
                        print("no version in realm, fetch newest champions")
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
                    self.searchChampions = self.champions
                    self.tableView.reloadData()
                    print("fetched newest champions, reload")
                    
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchChampions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "championCell", for: indexPath) as! ChampionTableViewCell

        // Configure the cell
        let champion = searchChampions[indexPath.row]
        
        cell.championName.text = champion.name
        cell.championTitle.text = champion.title
        if let image = champion.image?.full, let version = self.version {
            let url = "\(DataDragonRouter.Constants.baseUrl)/cdn/\(version)/img/champion/\(image)"
            cell.championImage.sd_setImage(with: URL(string: url))
        }
        
        return cell
    }

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedChampion = searchChampions[indexPath.row]
        self.performSegue(withIdentifier: "championSegue", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "championSegue" {
            if let champion = self.selectedChampion, let championVC = segue.destination as? ChampionViewController {
                    championVC.champion = champion
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchChampions = champions.filter({ $0.name.prefix(searchText.count) == searchText })
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchChampions = champions
        self.tableView.reloadData()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }

}
