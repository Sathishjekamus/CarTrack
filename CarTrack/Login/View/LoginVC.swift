//
//  LoginVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit
import FontAwesome_swift
import Reachability
import MessageUI
import CountryPickerView
import FirebaseCore
import FirebaseAuth

protocol CTLoginViewDelegate {
    func didStartLoadingContent()
    func didEndLoading(withError error:String?)
    func didAutherizedUser(_ user:User?, _ error: String?)
    
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
    @IBOutlet weak var countryMissingImageView: UIImageView!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    @IBOutlet weak var selectCountryTxtField: UITextField!
    
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CTUserListVC") as! CTUserListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func initializeVariables(){
        self.isPasswordVisible = false
        self.isUserNameMissing = false
        self.isPasswordMissing = false
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
        self.countryPickerView.setCountryByCode("IN")
        self.vm = CTLoginVM(networkManager: NetworkManager(), delegate: self)
    }
    
    override func initializeViews(){
        self.userNameMissingImgView.image = UIImage.fontAwesomeIcon(name: .exclamationCircle, style: .solid, textColor: .red, size: CGSize(width: 20, height: 20))
        self.passwordMissingImgView.image = UIImage.fontAwesomeIcon(name: .exclamationCircle, style: .solid, textColor: .red, size: CGSize(width: 20, height: 20))
        self.countryMissingImageView.image = UIImage.fontAwesomeIcon(name: .caretDown, style: .solid, textColor: .lightGray, size: CGSize(width: 20, height: 20))
        self.userNameTxtField.setLeftPaddingPoints(15)
        self.passwordTxtField.setLeftPaddingPoints(15)
        self.userNameTxtField.setRightPaddingPoints(30)
        self.passwordTxtField.setRightPaddingPoints(60)
        self.selectCountryTxtField.setLeftPaddingPoints(15)
        self.selectCountryTxtField.setRightPaddingPoints(30)
        self.userNameTxtField.setShadow()
        self.passwordTxtField.setShadow()
        self.selectCountryTxtField.setShadow()
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
            
        }else if self.userNameTxtField.text?.isValidEmail() == false {
            self.makeToastWithMessage(with: "Please enter valid email!")
            callBack?(false)
            
        }else if let password = self.passwordTxtField.text?.trim(), password == "" {
            self.isPasswordMissing = true
            callBack?(false)
            
        }else if  self.passwordTxtField.text?.trim().length ?? 0 < 6{
            self.makeToastWithMessage(with: "Password should contains 6 characters length!")
            callBack?(false)
            
        }else{
            callBack?(true)
        }
    }
    @IBAction func paswordShowAndHideButtonTapped(_ sender: Any) {
        self.isPasswordVisible = !self.isPasswordVisible
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
    
    @IBAction func emailSupportBtnTapped(_ sender: Any) {
        self.needSupportEmailBtn.pulsate()
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["CEOescalations@cartrack.com"])
            present(mail, animated: true)
        }
    }
    
    func showAuthenticationFailedAlert(){
        self.makeToastWithMessage(with: "Username or password is incorrect!")
    }
    
}

extension LoginVC:CTLoginViewDelegate {
  
    
    func didStartLoadingContent() {
        self.didBeginLoading()
    }
    
    func didEndLoading(withError error: String?) {
        self.didFinishLoading()
        self.makeToastWithMessage(with: error ?? "")
    }
    
    func didAutherizedUser(_ user:User?, _ error: String?) {
        OperationQueue.main.addOperation {
            self.didFinishLoading()
            if ((error == nil) || (user != nil)) {
                self.userNameTxtField.text = ""
                self.passwordTxtField.text = ""
                self.selectCountryTxtField.text = ""
                self.navigatetoHomeScreen()
            }else{
                self.showAuthenticationFailedAlert()
            }
        }
    }
    
    
}

extension LoginVC:MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension LoginVC:CountryPickerViewDelegate,CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       print(country)
    }
}
