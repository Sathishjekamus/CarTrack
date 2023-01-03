//
//  CTUserListCell.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import UIKit

protocol CTUserListCellProtocol {
    func navigateToDetailUserView(_ index:Int)
}

class CTUserListCell: UITableViewCell {

    @IBOutlet weak var detailViewBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var delegate:CTUserListCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(_ user:CTUser?, index:Int){
        self.detailViewBtn.tag = index
        self.nameLabel.text = user?.name ?? ""
        self.userNameLabel.text = user?.userName ?? ""
        self.emailLabel.text = user?.email ?? ""
    }

    @IBAction func navigateToUserDetailScreen(_ sender: Any) {
        let btn = sender as! UIButton
        self.delegate?.navigateToDetailUserView(btn.tag)
    }
    
}
