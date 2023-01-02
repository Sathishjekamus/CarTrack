//
//  NoNetworkAvailableView.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit

struct ErrorObject {
    var name:String?
    var imageStr:String?
}

class NoNetworkAvailableView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var noNetworkLabel: UILabel!
    var errorMessage = ""
    var errorImage = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    init(with obj:ErrorObject) {
        super.init(frame:CGRect())
        self.errorMessage = " \(obj.name ?? "") and try again."
        self.errorImage = obj.imageStr ?? ""
        self.commonInit()
    }
    
    @IBAction func retryOnClick(sender: UIButton) {
        self.retryAction?();
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("NoNetworkAvailableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.retryBtn.layer.cornerRadius = self.retryBtn.frame.size.height/2
        self.retryBtn.layer.masksToBounds = true
        self.noNetworkLabel.text = self.errorMessage
        self.backgroundView.dropShadow()
    }
       
       public var retryAction: (() -> Void)? = nil;

}
