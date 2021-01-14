//
//  FriendsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit

class FriendsController: UITableViewController {
    
<<<<<<< HEAD
    var friends = [
        "Ivanov Ivan",
        "Ivan Ivanov",
        "Asdf Jkl;"
        ]
=======
    
    let myFriends = Friends.makeFriends().sorted{ $0.userName < $1.userName }
>>>>>>> v4

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        friends.count
=======
        myFriends.count
>>>>>>> v4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else {return UITableViewCell() }
<<<<<<< HEAD
        cell.friendName.text = "\(friends[indexPath.row])"
        cell.friendPhoto.image = UIImage(named: "darth-vader")

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
=======
        cell.friendImage.image = myFriends[indexPath.row].userAvatar
        cell.friendName.text = myFriends[indexPath.row].userName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsSeq" {
            let controller = segue.destination as! PhotoViewController
            if let index = tableView.indexPathForSelectedRow {
                let user = myFriends[index.row]
                controller.images = user.userImages
            }
        }
    }
    
>>>>>>> v4

}
