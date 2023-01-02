//
//  CTBaseProtocol.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

protocol CTBaseProtocol {
     func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
    
}

protocol CTNetworkManagerBaseDelegate:CTBaseProtocol {
    func getUserList(completion:@escaping NetworkRouterCompletion)
}
