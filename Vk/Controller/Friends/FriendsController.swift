//
//  FriendsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    private var friends: Results<User>? {
        didSet {
            self.filteredFriends = friends
            self.tableView.reloadData()
        }
    }
    
    private var notificationToken: NotificationToken?
    
    var filteredFriends: Results<User>? {
        didSet {
            self.friendsDict.removeAll()
            self.firstLetters.removeAll()
            self.fillFriendsDict()
            tableView.reloadData()
        }
    }
    
    var friendsDict: [Character: [User]] = [:]
    var firstLetters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
//        self.filteredFriends = self.convertToArray(results: friends)
        self.friends = try? RealmServce.getBy(type: User.self)
        let networkService = NetworkService()
        networkService.getUserFriends() { [] friends in }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            self.firstLetters.count
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let nameFirstLetter = self.firstLetters[section]
            return self.friendsDict[nameFirstLetter]?.count ?? 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.notificationToken = self.friends?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.tableView.reloadData()
            case let .update(_,
                             deletions,
                             insertions,
                             modifications):
                self.tableView.update(deletions: deletions,
                                      insertions: insertions,
                                      modifications: modifications)
            case .error(let error):
                self.show(error: error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationToken?.invalidate()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
        
        let firstLetter = self.firstLetters[indexPath.section]
        if let users = self.friendsDict[firstLetter] {
            cell.configure(with: users[indexPath.row])
            cell.friendImage.addGestureRecognizer(UITapGestureRecognizer(target: cell.friendImage, action: #selector(cell.friendImage.handleTap)))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader") as? FriendsSectionHeader else { return nil }
        sectionHeader.textLabel?.text = String(self.firstLetters[section])
        sectionHeader.contentView.backgroundColor = .systemGray
        return sectionHeader
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        self.firstLetters.map{String($0)}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowUser",
            let controller = segue.destination as? PhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow
        else { return }
        let firstLetter = self.firstLetters[indexPath.section]
        if let users = self.friendsDict[firstLetter] {
            let user = users[indexPath.row]
            controller.user = user
        }
            
        }
    
    private func fillFriendsDict() {
        if let filteredFriends = self.filteredFriends {
            for user in filteredFriends {
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
    }
    
    private func logOut() {
        
    }
        
    
}

extension FriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends(with: searchText)
    }
    
    fileprivate func filterFriends(with text: String) {
        if text.isEmpty {
            self.filteredFriends = self.friends
            return
        }
        
        self.filteredFriends = self.friends?
            .filter("firstName CONTAINS[cd] %@ OR lastName CONTAINS[cd] %@", text, text)
    }
}
