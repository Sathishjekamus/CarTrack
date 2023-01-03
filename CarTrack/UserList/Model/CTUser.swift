//
//  CTUser.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import Foundation
import ObjectMapper

struct CTUserList:Mappable {
    var users = [CTUser]()
    init?(map: ObjectMapper.Map) {}
    init(){}
    mutating func mapping(map: ObjectMapper.Map) {
        self.users <- map["result"]
    }
}
struct CTUser:Mappable {
    var id:Int?
    var name:String?
    var userName:String?
    var email:String?
    var address = Address()
    var phone:String?
    var website:String?
    var company = Company()
    
    init?(map: ObjectMapper.Map) {}
    init(){}
    mutating func mapping(map: ObjectMapper.Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.userName <- map["username"]
        self.email <- map["email"]
        self.address <- map["address"]
        self.phone <- map["phone"]
        self.website <- map["website"]
        self.company <- map["company"]
    }
    
    
}

struct Address:Mappable {
    var street:String?
    var suite:String?
    var city:String?
    var zipcode:String?
    var geo:Geo?
    
    init?(map: ObjectMapper.Map) {}
    init(){}
    mutating func mapping(map: ObjectMapper.Map) {
        self.street <- map["street"]
        self.suite <- map["suite"]
        self.city <- map["city"]
        self.zipcode <- map["zipcode"]
        self.geo <- map["geo"]
    }
}

struct Geo:Mappable {
    var lat:String?
    var long:String?
    
    init?(map: ObjectMapper.Map) {}
    init(){}
    mutating func mapping(map: ObjectMapper.Map) {
        self.lat <- map["lat"]
        self.long <- map["lng"]
    }
}

struct Company:Mappable {
    var name:String?
    var catchPharse:String?
    var bs:String?
    
    init?(map: ObjectMapper.Map) {}
    init(){}
    mutating func mapping(map: ObjectMapper.Map) {
        self.name <- map["name"]
        self.catchPharse <- map["catchPhrase"]
        self.bs <- map["bs"]
    }
}
