//
//  CTUserListVM.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import Foundation

protocol CTUserListVMProtocol {
    var ui:CTUserListViewDelegate? { get set }
    func loadUsers()
}

class CTUserListVM:CTBaseVM, CTUserListVMProtocol {
    var ui: CTUserListViewDelegate?
    var networkManager: CTNetworkManagerBaseDelegate!
    
    init(networkManager: CTNetworkManagerBaseDelegate , delegate:CTUserListViewDelegate) {
         self.networkManager = networkManager
         self.ui = delegate
     }
    
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func loadUsers(){
        self.ui?.didStartLoadingContent()
        OperationQueue().addOperation {
            self.networkManager.getUserList { data, response, error in
                let networkObj = NetworkObject(data: data, response: response, error: error)
                self.convertJsonResponseIntoJsonModel(with: CTUserList(), netWorkObj: networkObj) { (result) in
                    OperationQueue.main.addOperation {
                            if let users = result?.users {
                                self.ui?.didLoadedUsers(users)
                            }
                    }
                    
                }
            }
        }
    }
    
    override func noNetworkError(_ error:String){
        self.ui?.didEndLoading(withError:error)
    }
    
    override func modelDecodableError(_ error:String){
        self.ui?.didEndLoading(withError:error)
    }
    
    override func noDataError(_ error:String){
        self.ui?.didEndLoading(withError:error)
    }
    
    override func networkFailureError(_ error:String){
        self.ui?.didEndLoading(withError: error)
    }
}
