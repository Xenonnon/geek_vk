//
//  FriendsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit
import Kingfisher

class FriendsController: UITableViewController {
    
    var friends: [User] = [] {
        didSet {
            self.filteredFriends = self.friends
        }
    }
    var filteredFriends = [User]() {
        didSet {
            self.friendsDict.removeAll()
            self.firstLetters.removeAll()
            self.fillFriendsDict()
            tableView.reloadData()
        }
    }
    
    var friendsDict: [Character: [User]] = [:]
    var firstLetters = [Character]()
    
    
//    let myFriends = Friends.makeFriends()
//    var filteredFriends = [Users]()
    
//    var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//
//    var filtering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var friendSections = [MyFriendsSections]()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.rowHeight = 60
//        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
//
//        self.filteredFriends = self.friends
//
//        let networkService = NetworkService()
//        networkService.loadFriends() { [weak self] friends in
//            self?.friends = friends
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.rowHeight = 60
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
                self.filteredFriends = self.friends
                let networkService = NetworkService()
                networkService.getUserFriends() { [weak self] friends in
                    self?.friends = friends
        
//        let friendsDictionary = Dictionary.init(grouping: myFriends) {
//            $0.userName.prefix(1)
//        }
//        friendSections = friendsDictionary.map { MyFriendsSections(title: String($0.key), items: $0.value) }
//        friendSections.sort { $0.title < $1.title }
                }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            self.firstLetters.count
    }
        
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if filtering {
//            return 1
//        }
//        else {
//            return friendSections.count
//        }
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let nameFirstLetter = self.firstLetters[section]
            return self.friendsDict[nameFirstLetter]?.count ?? 0
    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if filtering {
//            return filteredFriends.count
//        }
//        else {
//            return friendSections[section].items.count
//        }
//    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { friendSections.map { $0.title }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
        let firstLetter = self.firstLetters[indexPath.section]
        if let users = self.friendsDict[firstLetter] {
            cell.friendName.text = "\(users[indexPath.row].firstName) \(users[indexPath.row].lastName)"
            cell.friendImage.imageURL = users[indexPath.row].photo100
//            cell.avatarView.image = users[indexPath.row].avatar
            cell.friendImage.addGestureRecognizer(UITapGestureRecognizer(target: cell.friendImage, action: #selector(cell.friendImage.handleTap)))
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell
//        else { return UITableViewCell() }
//
//        var friends: Users
//        if filtering {
//            friends = filteredFriends[indexPath.row]
//        }
//        else {
//            friends = friendSections[indexPath.section].items[indexPath.row]
//        }
//        cell.friendImage.image = friends.userAvatar
//        cell.friendName.text = friends.userName
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader") as? FriendsSectionHeader else { return nil }
        sectionHeader.textLabel?.text = String(self.firstLetters[section])
        sectionHeader.contentView.backgroundColor = .systemGray
        return sectionHeader
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15.0))
//        view.backgroundColor = .systemGray5
//
//        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
//        label.font = UIFont(name: "Scrol", size: 17.0)
//        label.text = friendSections[section].title
//        view.addSubview(label)
//        return view
//    }

    private func fillFriendsDict() {
        for user in self.filteredFriends {
            let dictKey = user.firstName.first!
            if var users = self.friendsDict[dictKey] {
                users.append(user)
                self.friendsDict[dictKey] = users
            } else {
                self.firstLetters.append(dictKey)
                self.friendsDict[dictKey] = [user]
            }
        }
        self.firstLetters.sort()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowUser",
            let controller = segue.destination as? PhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow
        else { return }
        let user = self.filteredFriends[indexPath.row]
        controller.user = user
        
        
//        guard
//            segue.identifier == "FriendsSeq",
//            let controller = segue.destination as? FullscreenPhotoVC
//            let indexPath = tableView.indexPathForSelectedRow
//        else { return }
            
            
//            if let index = tableView.indexPathForSelectedRow {
//                var friends: Users
//                if filtering {
//                    friends = filteredFriends[index.row]
//                }
//                else {
//                    friends = friendSections[index.section].items[index.row]
//                }
//                controller.images = friends.userImages
//                controller.title = friends.userName
            
        }
}


//extension FriendsTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterFriends(with: searchText)
//    }
//
//    fileprivate func filterFriends(with text: String) {
//        if text.isEmpty {
//            self.filteredFriends = friends
//            return
//        }
//
//        self.filteredFriends = self.friends.filter {$0.firstName.lowercased().contains(text.lowercased())}
//    }
//}

//extension FriendsController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//        }
//    func filterContentForSearchText(_ searchText: String) {
//        filteredFriends = myFriends.filter({ (myFriends: Users) -> Bool in
//            return myFriends.userName.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//}

class FriendsSectionHeader: UITableViewHeaderFooterView {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
}
