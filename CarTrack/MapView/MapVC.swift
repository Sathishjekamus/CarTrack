//
//  MapVC.swift
//  CarTrack
//
//  Created by Helix Technical Services on 03/01/23.
//

import UIKit
import GoogleMaps

class MapVC: CTBaseVC {

   
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var locationMapView: GMSMapView!
    var user:CTUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let latStr = self.user?.address.geo?.lat ?? "37.36"
        let longStr = self.user?.address.geo?.long ?? "-122.0"
        let lat:Double = Double(latStr) ?? 37.36
        let long:Double = Double(longStr) ?? -122.0
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 6.0)
        locationMapView.camera = camera
        showMarker(position: camera.target)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = position
            marker.title = "Palo Alto"
            marker.snippet = "San Francisco"
            marker.map = locationMapView
        }
    override func initializeViews() {
        self.backImageView.image = UIImage.fontAwesomeIcon(name: .caretLeft, style: .solid, textColor: .white, size: CGSize(width: 20, height: 20))
    }


    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapVC: GMSMapViewDelegate{
        /* handles Info Window tap */
        func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
            print("didTapInfoWindowOf")
        }
        
        /* handles Info Window long press */
        func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
            print("didLongPressInfoWindowOf")
        }

        /* set a custom Info Window */
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 6
            
            let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
            lbl1.text = "Hi there!"
            view.addSubview(lbl1)
            
            let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
            lbl2.text = "I am a custom info window."
            lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
            view.addSubview(lbl2)

            return view
        }
        //MARK - GMSMarker Dragging
        func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
            print("didBeginDragging")
        }
        func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
            print("didDrag")
        }
        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
            print("didEndDragging")
        }
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = coordinate
        }
    }
