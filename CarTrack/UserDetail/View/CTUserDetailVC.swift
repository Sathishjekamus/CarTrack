//
//  CTUserDetailVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import UIKit
import MessageUI

protocol CTUserDetailViewDelegate {
    func didStartLoadingContent()
    func didEndLoading(withError error:String?)
    func didLoadedUsers(_ users:[CTUser]?, _ error: String?)
    
}

class CTUserDetailVC: CTBaseVC {
    var user:CTUser?
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: PaddingLabel!
    @IBOutlet weak var bsTxtField: UITextField!
    @IBOutlet weak var catchPhraseTxtField: UITextField!
    @IBOutlet weak var companyNameTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var zipCodeTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var suiteTxtField: UITextField!
    @IBOutlet weak var streetTxtField: UITextField!
    @IBOutlet weak var websiteTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailArrowImageView: UIImageView!
    @IBOutlet weak var locationArrowImageView: UIImageView!
    @IBOutlet weak var websiteArrowImageView: UIImageView!
    @IBOutlet weak var phoneArrowImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    override func initializeVariables() {
        
    }
    
    override func initializeViews() {
        self.backImageView.image = UIImage.fontAwesomeIcon(name: .caretLeft, style: .solid, textColor: .white, size: CGSize(width: 20, height: 20))
        self.emailArrowImageView.image = UIImage.fontAwesomeIcon(name: .caretRight, style: .solid, textColor: .darkGray, size: CGSize(width: 20, height: 20))
        self.phoneArrowImageView.image = UIImage.fontAwesomeIcon(name: .caretRight, style: .solid, textColor: .darkGray, size: CGSize(width: 20, height: 20))
        self.locationArrowImageView.image = UIImage.fontAwesomeIcon(name: .caretRight, style: .solid, textColor: .darkGray, size: CGSize(width: 20, height: 20))
        self.websiteArrowImageView.image = UIImage.fontAwesomeIcon(name: .caretRight, style: .solid, textColor: .darkGray, size: CGSize(width: 20, height: 20))
    }
    
    override func loadContent() {
        self.nameTxtField.text = "Name: \(user?.name ?? "")"
        self.userNameTxtField.text = "UserName: \(user?.userName ?? "")"
        self.emailTxtField.text = "Email: \(user?.email ?? "")"
        self.phoneTxtField.text = "Phone: \(user?.phone ?? "")"
        self.websiteTxtField.text = "Website: \(user?.website ?? "")"
        self.streetTxtField.text = "Street: \(user?.address.street ?? "")"
        self.suiteTxtField.text = "Suite: \(user?.address.suite ?? "")"
        self.cityTxtField.text = "City: \(user?.address.city ?? "")"
        self.zipCodeTxtField.text = "Zip Code: \(user?.address.zipcode ?? "")"
        self.locationTxtField.text = "Location"
        self.companyNameTxtField.text = "Company Name: \(user?.company.name ?? "")"
        self.catchPhraseTxtField.text = "Company Phrase: \(user?.company.catchPharse ?? "")"
        self.bsTxtField.text = "Company Bs: \(user?.company.bs ?? "")"
    }

    @IBAction func locationBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.user = self.user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func websiteBtnClicked(_ sender: Any) {
        let website = self.user?.website ?? "https://www.hackingwithswift.com"
        if let url = URL(string: website) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func phoneBtnClicked(_ sender: Any) {
        let number = self.user?.phone
        if let url = URL(string: "tel://\(number ?? "9965658042")"), !url.absoluteString.isEmpty {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emailBtnClicked(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let email = self.user?.email
            mail.setToRecipients([email ?? "sathishkalimuthan@gmail.com"])
            present(mail, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CTUserDetailVC:MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
