//
//  AmusementFacilitiesViewController.swift
//  amusement-facilities-app
//
//  Created by 谷口恭一 on 2022/10/02.
//

import Foundation
import UIKit



class AmusementFacilitiesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var amusementFacilities: [AmusementFacilitiesResponse] = [] {
        didSet {
            print("set")
            print(amusementFacilities)
            DispatchQueue.main.async {
                //print(jsonResponse.Item)
                self.tableView.reloadData()
                
            }
            //tableView.reloadData()
            
        }
    }
    
    private let items: [String] = []
    
    func unicodeDecode(beforeText: String) -> String {
        let wI = NSMutableString( string: beforeText )
        CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )
        return wI as String
    }
    
    private let recs: [String] = ["oidghjafsnlaisjkdf", "ああぢｊｈで"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL = URL(string: "https://t8lej63df8.execute-api.ap-northeast-1.amazonaws.com/amusement-facilities-stage/amusement-facilities")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let data = data {
                
                let str = String(data: data, encoding: .utf8) ?? ""
                let jsonData = self.unicodeDecode(beforeText: str).data(using: .utf8)!
                let jsonResponse = try! JSONDecoder().decode(JsonResponse.self, from: jsonData)
                
                self.amusementFacilities = [jsonResponse.Item]
                
            }
        })
        task.resume()
        
        tableView.dataSource = self
        
    }
}

extension AmusementFacilitiesViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amusementFacilities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "amusementFacilitiesTableViewCell", for: indexPath) as? AmusementFacilitiesTableViewCell else {
            fatalError("AmusementFacilitiesTableViewCell is not found")
        }
        cell.nameLable!.text = amusementFacilities[indexPath.row].name
        cell.recommendationLabel.text = amusementFacilities[indexPath.row].recommendation
        return cell
    }
}

class AmusementFacilitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    
    
}

struct JsonResponse: Decodable {
    var Item: AmusementFacilitiesResponse
}
 
struct AmusementFacilitiesResponse: Decodable {
    var placeId: String
    var name: String
    var location: String
    var price: String
    var recommendation: String
    //var pictureUrls: [String?]
    //var tag: [String]
}
