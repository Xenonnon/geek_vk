//
//  AllGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class AllGroupsController: UITableViewController {

<<<<<<< HEAD
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
=======
    let allGroups = Groups.makeGroups()
>>>>>>> v4

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else {return UITableViewCell() }
<<<<<<< HEAD
        cell.myGroupName.text = "\(allGroups[indexPath.row])"
        cell.myGroupImage.image = UIImage(named: "darth-vader")

        return cell
    }


=======
        cell.myGroupName.text = allGroups[indexPath.row].name
        cell.myGroupImage.image = allGroups[indexPath.row].image
        return cell
    }
>>>>>>> v4
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
