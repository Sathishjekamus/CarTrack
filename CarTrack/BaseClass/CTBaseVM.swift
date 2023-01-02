//
//  CTBaseVM.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation
import ObjectMapper

class CTBaseVM {
    var currentPage = 1
    
    var isNextPageAvailable = true
    
    var manager = NetworkManager()
    
    func noNetworkError(){}
    
    func modelDecodableError(){}
    
    func noDataError(){}
    
    func networkFailureError(error:String){}
    
    
    func convertJsonResponseIntoJsonModel<T:Mappable>(with modelObj:T, netWorkObj:NetworkObject, completion:((T?)->Void)?) {
        
        if netWorkObj.error != nil {
            self.noNetworkError()
        }else{
                   
        if let response = netWorkObj.response as? HTTPURLResponse {
            let result = self.manager.handleNetworkResponse(response)
             
                 switch result {
                 case .success:
                    guard let responseData = netWorkObj.data else {
                        self.noDataError()
                     return
                   }
                   
                    do {
                         let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let modelObj = Mapper<T>().map(JSONObject: jsonObj)
                         print(jsonObj)
                        completion?(modelObj)
                  }catch {
                      print(error)
                    self.modelDecodableError()
                    }
            
                  case .failure(let networkFailureError):
                    self.networkFailureError(error: networkFailureError)
                     
                 }
             }
    }

    }
    
    
    
    
    
    
}
