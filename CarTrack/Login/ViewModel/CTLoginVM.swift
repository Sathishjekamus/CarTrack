//
//  CTLoginVM.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation
import ObjectMapper
import FirebaseCore
import FirebaseAuth


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
        self.ui?.didStartLoadingContent()
        Auth.auth().signIn(withEmail: userName, password: password, completion: { (auth, error) in
                    if let maybeError = error { //if there was an error, handle it
                        let err = maybeError as NSError
                        switch err.code {
                        case AuthErrorCode.wrongPassword.rawValue:
                            self.ui?.didEndLoading(withError: "wrong password!")
                    
                        case AuthErrorCode.invalidEmail.rawValue:
                            self.ui?.didEndLoading(withError: "invalid email!")

                        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                            self.ui?.didEndLoading(withError: "Account Exists with Different Credential!")
                            
                        default:
                            self.ui?.didEndLoading(withError: "unknown error: \(err.localizedDescription)")
                        }
                    } else {
                        if let user = auth?.user {
                            self.ui?.didAutherizedUser(user, nil)
                        } else {
                            self.ui?.didEndLoading(withError:"User is not Authorised!")
                        }
                    }
                })
    }
    
    
}
