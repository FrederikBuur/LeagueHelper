//
//  SetupViewController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 25/10/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class SetupViewController: UIViewController {
    
    private var summonerController: SummonerController?
    private let disposeBag = DisposeBag()
    private var summoner: Summoner? = nil
    
    @IBOutlet weak var summonerNameTextField: UITextField!
    @IBOutlet weak var setupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if summonerController == nil {
            summonerController = SummonerController()
        }
        
    }
    
    @IBAction func searchSummoner(_ sender: Any) {
        if let summonerName = summonerNameTextField.text {
            if !summonerName.isEmpty {
                if isSummonerNameValid(name: summonerName) {
                    fetchSummoner(named: summonerName)
                } else {
                    setupLabel.text = "Invalid summoner name"
                }
            }
        }
    }
    
    private func fetchSummoner(named summonerName: String) {
        summonerController?.getSummoner(named: summonerName)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (summoner) in
                    // save summoner
                    self.summoner = summoner
                    // prepare for segue
                    self.performSegue(withIdentifier: "showProfile", sender: nil)
            }, onError: { (error) in
                if let v = error as? AFError {
                    if v.responseCode == 404 {
                        self.setupLabel.text = "Summoner doesn't exist"
                        self.summonerNameTextField.text = ""
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func isSummonerNameValid(name: String) -> Bool {
        if name.count <= 2 {return false}
        let regex = try! NSRegularExpression(pattern: "^[0-9\\p{L} _.]+$")
        let match = regex.numberOfMatches(in: name,
                                          options: [],
                                          range: NSRange(location: 0, length: name.count))
        if match > 0 {
            return true
        } else {
            return false
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile" {
            if let destination = segue.destination as? UITabBarController,
                let summoner = self.summoner {
                if let profileVC: ProfileViewController =  destination.viewControllers?.first as? ProfileViewController {
                    profileVC.mSummoner = summoner
                }
            }
        }
     }
 
    
}
