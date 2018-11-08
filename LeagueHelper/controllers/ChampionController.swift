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

class ChampionController {
    
    func getChampions(version: String, in region: String) -> Observable<[Champion]> {
        return Observable.create({ (emitter) -> Disposable in
            
             let request = Alamofire.request(DataDragonRouter.championList(version, region)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    // parse jason to response object
                    let championsResponse = ChampionsResponse.parseJson(json: JSON(value))
                    let champions = RealmController.sharedInstance.saveChampionsOrUpdate(champions: <#T##[Champion]#>)(champions: championsResponse.data)
                    
                    emitter.onNext(cham)
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
