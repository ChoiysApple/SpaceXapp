//
//  ViewModel.swift
//  SpaceXapp
//
//  Created by Daegeon Choi on 2022/05/18.
//

import Foundation
import RxRelay
import RxSwift
import Apollo

class ViewModel {
    
    let launchObservable = PublishRelay<[LaunchListQuery.Data.Launch.Launch]>()
    
    func requestData() {
        _ = APIService.fetchResult(query: LaunchListQuery())
            .take(1)
            .debug()
            .bind(to: launchObservable)
        
    }
}
