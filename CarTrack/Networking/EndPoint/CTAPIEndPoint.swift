//
//  CTAPIEndPoint.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

enum URLEndPoint:String {
    case beta = "https://beta-jsonplaceholder.typicode.com/users"
    case staging = "https://staging-jsonplaceholder.typicode.com/users"
    case live = "https://jsonplaceholder.typicode.com/users"

}

struct CTBaseURL {
   static var httpsBase:String = ""
}


enum CTAPIEndPoint {
    case getUserList
    
    var path:String {
        switch self {
        case .getUserList:
            return ""
        }
    }
    
}
