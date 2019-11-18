//
//  ViewController.swift
//  Loco2
//
//  Created by 宮崎直久 on 2019/11/06.
//  Copyright © 2019 宮崎直久. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, GMSMapViewDelegate {
    
//    var locationManager: CLLocationManager!
//    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 35.665751, longitude: 139.728687, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 35.665751, longitude: 139.728687)
        marker.title = "六本木"
        marker.snippet = "東京都港区六本木７丁目４−１"
        marker.map = mapView
        
        Alamofire.request("https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=35.662654694078626&lon=139.73135330250383&dist=2&query=%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%B3&appid=dj00aiZpPVFGM0Y1N3NDbVRFeCZzPWNvbnN1bWVyc2VjcmV0Jng9ODA-&output=json").responseJSON { response in
            
            if let jsonObject = response.result.value {
// 変数jsonにresponse.result.valueを代入すると、通信をした結果、変数jsonに入ってくる。
//                print("JSON: \(json)")
//                その通信した結果がここに入ってくる。
                let json = JSON(jsonObject)
                let features = json["Features"]
                
                
                // If json is .Dictionary
                for (_ ,subJson):(String, JSON) in features {
                   let name = subJson["Name"].stringValue
                   let address = subJson["Property"]["Address"].stringValue
                    let coordinates = subJson["Geometry"]["Coordinates"].stringValue
                    let coordinatesArray = coordinates.split(separator: ",")
                    let lat = coordinatesArray[1]
                    let lon = coordinatesArray[0]
                    let latDouble = Double(lat)
                    let lonDouble = Double(lon)
//                    print(subJson["Name"])
//                    print(subJson["Property"]["Address"])
//                    print(subJson["Geometry"]["Coordinates"])
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latDouble!, longitude: lonDouble!)
                    marker.title = name
                    marker.snippet = address
                    marker.map = mapView
                }
            }
        }

    }


}

