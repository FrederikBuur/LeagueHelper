//
//  ChampionController.swift
//  LeagueHelper
//
//  Created by Frederik Buur on 04/11/2018.
//  Copyright © 2018 Frederik Buur. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import RxSwift
import SwiftyJSON

class DataDragonController {
    
    func getLatestVersion() -> Observable<Version> {
        return Observable.create({ (emitter) -> Disposable in
            
            let request = Alamofire.request(DataDragonRouter.latestVersion).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let version = Version.getLatestVersion(json: JSON(value))
                    
                    emitter.onNext(version)
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
    
    func getSummonerSpells(version: String, region: String) -> Observable<SummonerSpellResponse> {
        return Observable.create({ (emitter) -> Disposable in
            let request = Alamofire.request(DataDragonRouter.summonerSpells(version, region)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let summonerSpellResponse = SummonerSpellResponse.parseJson(json: JSON(value))
                    RealmController.sharedInstance.saveSummonerSpellsOrUpdate(summonerSpellResponse: summonerSpellResponse)
                    emitter.onNext(summonerSpellResponse)
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
    
    func getChampions(version: String, in region: String) -> Observable<ChampionsResponse> {
        return Observable.create({ (emitter) -> Disposable in
            
             let request = Alamofire.request(DataDragonRouter.championList(version, region)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    // parse jason to response object
                    let championsResponse = ChampionsResponse.parseJson(json: JSON(value))
                    championsResponse.data = championsResponse.data.sorted(by: {$0.name < $1.name})
                    RealmController.sharedInstance.saveChampionsOrUpdate(championResponse: championsResponse)
                    
                    emitter.onNext(championsResponse)
                    emitter.onCompleted()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
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
