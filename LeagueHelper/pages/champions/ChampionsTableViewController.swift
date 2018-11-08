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

    private let disposeBag = DisposeBag()
    private var champions: [Champion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //test
        let controller = ChampionController()
        controller.getChampions(version: "8.22.1", in: "en_US")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (championsResponse) in
                    
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
