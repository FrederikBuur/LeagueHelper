//
//  SummonerController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 25/10/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

class SummonerController {
    
    func getSummoner(named summonerName: String) -> Observable<Summoner> {
        return Observable.create({ (emitter) -> Disposable in
            let request = Alamofire.request(LeagueRouter.summonerByName(summonerName)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let summoner = Summoner.parsJSON(json: JSON(value))
                    emitter.onNext(summoner)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                    emitter.onCompleted()
                }
                
            }
            return Disposables.create {
                 request.cancel()
            }
        })
    }
    
    func getLeaguePosition(id: Int) -> Observable<Array<LeaguePosition>> {
        return Observable.create({ (emitter) -> Disposable in
            let request = Alamofire.request(LeagueRouter.getLeaguePosition(id)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let leaguePositions = LeaguePosition.parsJSON(json: JSON(value))
                    emitter.onNext(leaguePositions)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                    emitter.onCompleted()
                }
            }
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
}
