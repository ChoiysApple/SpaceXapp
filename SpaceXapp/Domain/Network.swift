//
//  Network.swift
//  SpaceXapp
//
//  Created by Daegeon Choi on 2022/05/17.
//

import Foundation
import Apollo

enum ListSection: Int, CaseIterable {
  case launches
}

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
    
    
}
