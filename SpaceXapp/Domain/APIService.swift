//
//  APIService.swift
//  SpaceXapp
//
//  Created by Daegeon Choi on 2022/05/18.
//

import Foundation
import RxSwift
import Apollo

enum ApolloError: Error {
    case partError
    case fetchError
}

class APIService {
    
    static func fetchRequest(query: Any, onComplete: @escaping (Result<GraphQLResult<LaunchListQuery.Data>, Error>) -> Void) {
                
        //TODO: Fix query input
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
          switch result {
            case .success(let graphQLResult):
              print("Success! Result: \(#function)")
              onComplete(.success(graphQLResult))
              return
            case .failure(let error):
              print("Failure! Error: \(error)")
              onComplete(.failure(error))
              return
          }
        }
        
        
    }
    
    static func fetchResult(query: Any) -> Observable<[LaunchListQuery.Data.Launch.Launch]> {
        return Observable.create { emitter in

            fetchRequest(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    
                    if let launchConnection = graphQLResult.data?.launches {
                        let result = launchConnection.launches.compactMap { $0 }
                        emitter.onNext(result)
                        emitter.onCompleted()
                        
                        return
                    }
                  
                    if let errors = graphQLResult.errors {
                        print("GraphQL Error(s): \(errors)")
                        emitter.onError(ApolloError.partError)
                        return
                    }
                    
                case .failure(let error):
                    emitter.onError(error)
                }
                
            }
            
            

            return Disposables.create()
        }
    }
}
