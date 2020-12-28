//
//  AllGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class AllGroupsController: UITableViewController {

    var allGroups = [
        "4ch",
        "IGM",
        "BMW",
        "gr1",
        "gr2",
        "gr3"
        ]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else {return UITableViewCell() }
        cell.myGroupName.text = "\(allGroups[indexPath.row])"
        cell.myGroupImage.image = UIImage(named: "darth-vader")

        return cell
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
