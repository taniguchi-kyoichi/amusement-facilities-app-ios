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
    
    private let items: [String] = ["a", "b"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
}

extension AmusementFacilitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
                        UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = items[indexPath.row]
            return cell
    }
}
