//
//  CTLoginVM.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation
import ObjectMapper

protocol CTLoginVMProtocol {
    var ui:CTLoginViewDelegate? { get set }
    func authenticateCredentials(with userName:String, password:String)
    
    
}

class CTLoginVM:CTBaseVM,CTLoginVMProtocol{
    var ui: CTLoginViewDelegate?
    var networkManager: CTNetworkManagerBaseDelegate!
    
    
    init(networkManager: CTNetworkManagerBaseDelegate , delegate:CTLoginViewDelegate) {
         self.networkManager = networkManager
         self.ui = delegate
     }
    
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func authenticateCredentials(with userName: String, password: String) {
        
    }
    
    
}
