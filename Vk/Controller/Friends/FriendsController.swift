//
//  FriendsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit

class FriendsController: UITableViewController {
    
    
    let myFriends = Friends.makeFriends()//.sorted{ $0.userName < $1.userName }
    
    var filteredFriends = [Users]()
    var friendSections = [MyFriendsSections]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsDictionary = Dictionary.init(grouping: myFriends) {
            $0.userName.prefix(1)
        }
        friendSections = friendsDictionary.map { MyFriendsSections(title: String($0.key), items: $0.value) }
        friendSections.sort { $0.title < $1.title }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            return friendSections.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { friendSections.map { $0.title } }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendSections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else {return UITableViewCell() }
        
        var friends: Users
        friends = friendSections[indexPath.section].items[indexPath.row]
        
        cell.friendImage.image = friends.userAvatar
        cell.friendName.text = friends.userName
//        cell.friendImage.image = myFriends[indexPath.row].userAvatar
//        cell.friendName.text = myFriends[indexPath.row].userName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15.0))
        view.backgroundColor = .systemGray5
        
        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
        
        label.font = UIFont(name: "Scrol", size: 17.0)
        label.text = friendSections[section].title
        view.addSubview(label)
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsSeq" {
            let controller = segue.destination as! PhotoViewController
            if let index = tableView.indexPathForSelectedRow {
                var friends: Users
                friends = friendSections[index.section].items[index.row]
                controller.images = friends.userImages
                controller.title = friends.userName
//                let user = myFriends[index.row]
//                controller.images = user.userImages
            }
        }
    }
    

}
