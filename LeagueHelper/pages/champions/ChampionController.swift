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

class ChampionController {
    
    func getChampions(version: String, in region: String) -> Observable<ChampionsResponse> {
        return Observable.create({ (emitter) -> Disposable in
            
            let request = Alamofire.request(LeagueRouter.championList(version, region)).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    // parse jason to response object
                    emitter.onNext(<#T##element: ChampionsResponse##ChampionsResponse#>)
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
