//
//  CTUserListAPI.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

public enum CTUserListAPI {
    case getUserList
}


extension CTUserListAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: CTBaseURL.httpsBase) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return CTAPIEndPoint.getUserList.path
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getUserList:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization":""]
    }
    
    
  
}
