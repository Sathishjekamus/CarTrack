//
//  CTUserListVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit
import MessageUI


protocol CTUserListViewDelegate {
    func didStartLoadingContent()
    func didEndLoading(withError error:String?)
    func didLoadedUsers(_ users:[CTUser])
}

class CTUserListVC: CTBaseVC {

    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    var users:[CTUser]?
    var vm:CTUserListVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func initializeVariables() {
        self.vm = CTUserListVM(networkManager: NetworkManager(), delegate: self)
    }

    override func initializeViews() {
        self.userListTableView.isHidden = true
        self.backImageView.image = UIImage.fontAwesomeIcon(name: .chevronLeft, style: .solid, textColor: .white, size: CGSize(width: 20, height: 20))
        self.titleLabel.text = "Users List"
    }
    
    override func loadContent() {
        self.vm?.loadUsers()
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CTUserListVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTUserListCell", for: indexPath) as! CTUserListCell
        cell.delegate = self
        let user = self.users?[indexPath.row]
        cell.loadCell(user, index: indexPath.row)
        return cell
    }
    
}

extension CTUserListVC:CTUserListCellProtocol {
    func navigateToDetailUserView(_ index: Int) {
        let user = self.users?[index]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CTUserDetailVC") as! CTUserDetailVC
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToEmailWindow(_ index:Int) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let user = self.users?[index]
            let email = user?.email
            mail.setToRecipients([email ?? "sathishkalimuthan@gmail.com"])
            present(mail, animated: true)
        }
    }
    
    
}

extension CTUserListVC: CTUserListViewDelegate {
    func didStartLoadingContent() {
        self.didBeginLoading()
    }
    
    func didEndLoading(withError error: String?) {
        self.didFinishLoading()
        self.makeToastWithMessage(with: error ?? "")
    }
    
    func didLoadedUsers(_ users: [CTUser]) {
        self.didFinishLoading()
        self.users = users
        self.userListTableView.isHidden = false
        self.userListTableView.reloadData()
    }
    
    
}

extension CTUserListVC:MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
