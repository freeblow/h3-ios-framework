//
//  DecodeViewController.swift
//  h3SwiftTestApp
//
//  Created by 十亀眞怜 on 2018/07/28.
//

import UIKit
import H3Swift

class DecodeViewController: UIViewController {

    var h3Index: H3Index? = nil
    @IBOutlet weak var h3IndexField: UITextField!
    @IBOutlet weak var decodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpdateButtonTouched(_ sender: Any) {
        guard var idx = h3IndexField.text else {
            return
        }
        h3Index = H3Index(string: idx)
        decodeTableView.reloadData()
    }
}

extension DecodeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 2
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Location"
        case 1:
            return "Hexagon"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        guard let idx = self.h3Index else {
            return cell
        }
        switch(indexPath.section) {
        case 0:
            let coord = GeoCoord.from(idx)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Latitude"
                cell.detailTextLabel?.text = "\(radsToDegs(coord.lat))"
            } else {
                cell.textLabel?.text = "Longitude"
                cell.detailTextLabel?.text = "\(radsToDegs(coord.lon))"
            }
        case 1:
            let buf = idx.geoBoundary()
            cell.textLabel?.text = "\(indexPath.row)"
            cell.detailTextLabel?.text = "\(geoCoordToString(buf[indexPath.row]))"
        default:
            break
        }
        return cell
    }
    
    fileprivate func geoCoordToString(_ coord: GeoCoord) -> String {
        return "\(radsToDegs(coord.lat)),\(radsToDegs(coord.lon))"
    }
}
