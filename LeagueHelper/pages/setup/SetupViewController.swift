//
//  SetupViewController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 25/10/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var summonerNameTextField: UITextField!
    @IBOutlet weak var setupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func searchSummoner(_ sender: Any) {
        
        if let summonerName = summonerNameTextField.text {
            if !summonerName.isEmpty {
                if isSummonerNameValid(name: summonerName) {
                    
                } else {
                    setupLabel.text = "Invalid summoner name"
                }
            }
        }
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
