//
//  NetworkManager.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case internalServerError = "Sorry we could not process your request. Please try again later!."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}




struct NetworkManager:CTNetworkManagerBaseDelegate {
    
    func getUserList(completion:@escaping NetworkRouterCompletion){
       let router = Router<CTUserListAPI>()
        router.request(.getUserList, completion: completion)
    }
    
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...499: return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...599: return .failure(NetworkResponse.internalServerError.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}





