//
//  CTBaseVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit
import Toast_Swift

class CTBaseVC: UIViewController, CTBaseVCProtocol {
        
        var activityIndicator:UIActivityIndicatorView?
        var itemCount = -1
        var obj = ErrorObject()
        let picker = UIImagePickerController()
        var isRefreshEnabled = false
        var overlay: UIView?
        var loaderImageView:UIImageView?
        
        lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.blue
            
            return refreshControl
        }()
        
        lazy var noNetworkView: NoNetworkAvailableView = {
        
            let noNetworkView = NoNetworkAvailableView(with: self.obj)
             // To resize
            noNetworkView.frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
            self.view.addSubview(noNetworkView);
            noNetworkView.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
            noNetworkView.layoutIfNeeded();
            
             return noNetworkView;
         }();
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.initializeVariables()
            self.initializeViews()
            self.loadContent()
            // Do any additional setup after loading the view.
        }
        
        func initializeVariables(){}
        
        func initializeViews(){}
        
        func loadContent(){}
        
        
        @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
          self.isRefreshEnabled = true
          self.loadContent()
        }
        
        func reportNoNetwork() {
            OperationQueue.main.addOperation {
                self.noNetworkView.retryAction = self.reloadPage;
                self.noNetworkView.isHidden = false;
            }
        }
        
         public func reloadPage() {
            self.noNetworkView.isHidden = true;
            self.loadContent()
         }
        
         public func didBeginLoading() {
            OperationQueue.main.addOperation {
                self.showLoadingOverlay()
               }
           }
           
           public func didFinishLoading() {
            OperationQueue.main.addOperation {
                self.isRefreshEnabled = false
                self.hideLoadingOverlay()
                self.refreshControl.endRefreshing()
                
               }
        
           }
        
        
        
        func alert(title: String?, message: String!, okTitle: String! = "OK", okCallBack:(() -> Void)? = nil, cancelTitle:String? = nil,cancelCallBack:(()-> Void)? = nil)
          {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
            alertController.view.accessibilityIdentifier = title
            alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction) -> Void in
                  okCallBack?();
              }));
              if (cancelTitle != nil)
              {
                alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action: UIAlertAction) -> Void in
                      cancelCallBack?();
                  }));
              }
            self.present(alertController, animated: true, completion: nil);
          }
        
        func makeToastWithMessage(with msg:String, color:UIColor? = .darkGray){
            OperationQueue.main.addOperation {
                var style = ToastStyle()
                style.backgroundColor = color!
                style.messageColor = UIColor.white
                UIApplication.topViewController()?.view.makeToast(msg, duration: 3.0, position: .bottom, style: style)
            }
        }
        
        func hideLoadingOverlay() {
            OperationQueue.main.addOperation {
                UIView.animate(withDuration: 0.2, animations: {
                    self.overlay?.alpha = 0
                }, completion: { (success) in
                    self.overlay?.removeFromSuperview()
                })
            }
        }
    
    func initOverlay() {
        overlay = UIView()
        overlay?.backgroundColor =  UIColor.black.withAlphaComponent(0.7)

      }
    
    func initLoaderImageView(){
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator?.color = .darkGray
        self.activityIndicator?.startAnimating()
    }
    
        func showLoadingOverlay(){
            OperationQueue.main.addOperation {
                if (self.overlay == nil) {
                    self.initOverlay()
                }
                self.overlay?.alpha = 1
                
                if (self.loaderImageView == nil) {
                    self.initLoaderImageView()
                }
               
                self.view.addSubview(self.overlay!)
                let loaderBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
               loaderBackgroundView.center = self.view.center
               loaderBackgroundView.backgroundColor = UIColor.clear
               loaderBackgroundView.makeCircle()
               self.overlay?.addSubview(loaderBackgroundView)
               self.activityIndicator?.center = self.view.center
               self.overlay?.addSubview(self.activityIndicator!)
               self.overlay?.frame = self.view.frame
               self.overlay?.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.overlay?.alpha = 1
                })
            }

        }
        
        func showLoadMoreActivityIndicator() -> UIActivityIndicatorView{
            let spinner = UIActivityIndicatorView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: 30, height: 30))
            spinner.startAnimating()
            spinner.color = UIColor.blue
           return spinner
        }
        
        func removeStoredCredentials(){
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
            UserDefaults.standard.synchronize()
        }
    
}

extension CTBaseVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
