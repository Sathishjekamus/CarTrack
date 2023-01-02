//
//  LoginVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit
import FontAwesome_swift

protocol CTLoginViewDelegate {
    func didStartLoadingContent()
    func didEndLoading(withError error:String)
    func didEndLoadingContent(_ success:Bool?, _ error: String?)
    
}

class LoginVC: CTBaseVC {
    
    @IBOutlet weak var needSupportEmailBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var userNameMissingImgView: UIImageView!
    @IBOutlet weak var showAndHidePaswordImgView: UIImageView!
    @IBOutlet weak var passwordMissingImgView: UIImageView!
    @IBOutlet weak var signInBtn: ButtonExtension!
    
    var isPasswordVisible:Bool = false {
        didSet {
            
            let imageNmae:FontAwesome = isPasswordVisible == true ? FontAwesome.eyeSlash:FontAwesome.eye
            self.passwordTxtField.isSecureTextEntry = !isPasswordVisible
            self.showAndHidePaswordImgView.image = UIImage.fontAwesomeIcon(name: imageNmae, style: .solid, textColor: .lightGray, size: CGSize(width: 30, height: 15))
            
        }
    }
    
    var isUserNameMissing:Bool = false {
        didSet{
            self.userNameMissingImgView.isHidden = !isUserNameMissing
        }
    }
    
    var isPasswordMissing:Bool = false {
        didSet{
            self.passwordMissingImgView.isHidden = !isPasswordMissing
        }
    }
    
    
    var vm:CTLoginVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.checkWhetherLoggedInAlready()
    }
    
    func checkWhetherLoggedInAlready(){
        if CTSingleton.shared.isLoggedInAlready {
            self.navigatetoHomeScreen()
        }
        
    }
    
    func navigatetoHomeScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "")
    }
    
    override func initializeVariables(){
        self.isPasswordVisible = false
        self.isUserNameMissing = false
        self.isPasswordMissing = false
        self.vm = CTLoginVM(networkManager: NetworkManager(), delegate: self)
    }
    
    override func initializeViews(){
        self.userNameMissingImgView.image = UIImage.fontAwesomeIcon(name: .exclamationCircle, style: .solid, textColor: .red, size: CGSize(width: 20, height: 20))
        self.passwordMissingImgView.image = UIImage.fontAwesomeIcon(name: .exclamationCircle, style: .solid, textColor: .red, size: CGSize(width: 20, height: 20))
        self.userNameTxtField.setLeftPaddingPoints(15)
        self.passwordTxtField.setLeftPaddingPoints(15)
        self.userNameTxtField.setRightPaddingPoints(30)
        self.passwordTxtField.setRightPaddingPoints(60)
        self.userNameTxtField.setShadow()
        self.passwordTxtField.setShadow()
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        self.signInBtn.pulsate()
        self.view.endEditing(true)
        self.validateFields { (isSuccess) in
            if isSuccess {
                self.validateLoginCredentials()
            }
        }
    }
    
    func validateFields(callBack:((Bool)->Void)?){
        if let userName = self.userNameTxtField.text?.trim(), userName == ""   {
            self.isUserNameMissing = true
            callBack?(false)
            
        }else if let password = self.passwordTxtField.text?.trim(), password == "" {
            self.isPasswordMissing = true
            callBack?(false)
            
        }else if self.userNameTxtField.text?.isValidEmail() == false {
            self.makeToastWithMessage(with: "Please enter valid email!")
            callBack?(false)
            
        }else if  self.passwordTxtField.text?.trim().length ?? 0 < 6{
            self.makeToastWithMessage(with: "Password should contains 6 characters length!")
            callBack?(false)
            
        }else{
            callBack?(true)
        }
    }
    
    func validateLoginCredentials() {
        let reachability = try? Reachability()
        if (reachability?.connection == Reachability.Connection.unavailable) {
            self.makeToastWithMessage(with: "Please check your internet connection!")
        }else{
            let username = self.userNameTxtField.text?.trim()
            let password = self.passwordTxtField.text?.trim()
            OperationQueue().addOperation {
                self.vm?.authenticateCredentials(with: username?.lowercased() ?? "", password: password ?? "")
            }
            
        }
    }
    
    func callingLoginAPI(){
        
    }
    
}

extension LoginVC:CTLoginViewDelegate {
    func didStartLoadingContent() {
        
    }
    
    func didEndLoading(withError error: String) {
        
    }
    
    func didEndLoadingContent(_ success: Bool?, _ error: String?) {
        
    }
    
    
}
