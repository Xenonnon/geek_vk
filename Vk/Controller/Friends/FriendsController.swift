//
//  FriendsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit

class FriendsController: UITableViewController {
    
    var friends = [
        "Ivanov Ivan",
        "Ivan Ivanov",
        "Asdf Jkl;"
        ]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else {return UITableViewCell() }
        cell.friendName.text = "\(friends[indexPath.row])"
        cell.friendPhoto.image = UIImage(named: "darth-vader")

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
