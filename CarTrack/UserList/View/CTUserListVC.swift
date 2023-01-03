//
//  CTUserListVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit

protocol CTUserListViewDelegate {
    func didStartLoadingContent()
    func didEndLoading(withError error:String?)
    func didEndLoadingContent(_ success:Bool?, _ error: String?)
    
}

class CTUserListVC: CTBaseVC {

    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    var users:[CTUser]?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func initializeVariables() {
        
    }

    override func initializeViews() {
        
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        
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
//        self.load
        return cell
    }
    
}

extension CTUserListVC:CTUserListCellProtocol {
    func navigateToDetailUserView(_ index: Int) {
        let user = self.users?[index]
    }
    
    
}
