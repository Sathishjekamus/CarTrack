//
//  EndPoint.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

