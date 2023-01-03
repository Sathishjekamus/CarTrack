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
    
    func noNetworkError(_ error:String){}
    
    func modelDecodableError(_ error:String){}
    
    func noDataError(_ error:String){}
    
    func networkFailureError(_ error:String){}
    
    
    func convertJsonResponseIntoJsonModel<T:Mappable>(with modelObj:T, netWorkObj:NetworkObject, completion:((T?)->Void)?) {
        
        if netWorkObj.error != nil {
            self.noNetworkError("Network not available!")
        }else{
                   
        if let response = netWorkObj.response as? HTTPURLResponse {
            let result = self.manager.handleNetworkResponse(response)
             
                 switch result {
                 case .success:
                    guard let responseData = netWorkObj.data else {
                        self.noDataError("No data available!")
                     return
                   }
                   
                    do {
                         let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let result = ["result":jsonObj]
                        let modelObj = Mapper<T>().map(JSONObject: result)
                         print(jsonObj)
                        completion?(modelObj)
                  }catch {
                      print(error)
                    self.modelDecodableError("Decodable error!")
                    }
            
                  case .failure(let networkFailureError):
                     self.networkFailureError(networkFailureError)
                     
                 }
             }
    }

    }
    
    
    
    
    
    
}
