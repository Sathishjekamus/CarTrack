//
//  CTUserListCell.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import UIKit
import FontAwesome_swift

protocol CTUserListCellProtocol {
    func navigateToDetailUserView(_ index:Int)
}

class CTUserListCell: UITableViewCell {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailViewBtn: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    var delegate:CTUserListCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailImageView.image = UIImage.fontAwesomeIcon(name: .caretRight, style: .solid, textColor: .darkGray, size: CGSize(width: 20, height: 20))
      
    }
    
    func loadCell(_ user:CTUser?, index:Int){
        self.detailViewBtn.tag = index
        self.nameTxtField.text = "Name: \(user?.name ?? "")"
        self.userNameTxtField.text = "User Name: \(user?.userName ?? "")"
        self.emailTxtField.text = "Email: \(user?.email ?? "")"
    }

    @IBAction func navigateToUserDetailScreen(_ sender: Any) {
        let btn = sender as! UIButton
        self.delegate?.navigateToDetailUserView(btn.tag)
    }
    
    @IBAction func emailBtnTapped(_ sender: Any) {
        
    }
}
