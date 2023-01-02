//
//  CTUserListProtocol.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

protocol CTUserListProtocol {
    func getUserList(_ completion:@escaping NetworkRouterCompletion)
}

extension NetworkManager:CTUserListProtocol {
    func getUserList(_ completion:@escaping NetworkRouterCompletion) {
        let router = Router<CTUserListAPI>()
        router.request(.getUserList, completion: completion)
    }
}
