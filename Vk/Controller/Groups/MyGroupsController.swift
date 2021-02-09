//
//  MyGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var myGroups: Results<Group>? {
        didSet {
            self.filteredGroups = self.myGroups
            self.tableView.reloadData()
        }
    }
    
    var notificationToken: NotificationToken?
    
    var filteredGroups: Results<Group>? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsController,
            let indexPath = controller.tableView.indexPathForSelectedRow,
            let myGroups = self.myGroups,
            !myGroups.contains(where: {$0.name == controller.allGroups[indexPath.row].name})
        else { return }
        
        let group = controller.allGroups[indexPath.row]
        var newGroupList = Array(myGroups)
        newGroupList.append(group)
        try? RealmServce.save(items: newGroupList)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchBar.delegate = self
        tableView.rowHeight = 60
        let networkService = NetworkService()
        networkService.getUserGroups() { [] groups in }
        self.myGroups = try? RealmServce.getBy(type: Group.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.notificationToken = self.myGroups?.observe { [weak self] change in
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        
        if let group = self.filteredGroups?[indexPath.row] {
            cell.configure(with: group)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let g = self.filteredGroups?[indexPath.row],
                  let objectToDelete = self.myGroups?.filter("NOT id != %@", g.id)
            else { return }
            try? Realm().write {
                try? Realm().delete(objectToDelete)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MyGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterGroups(with: searchText)
    }
    
    fileprivate func filterGroups(with text: String) {
        if text.isEmpty {
            self.filteredGroups = self.myGroups
            self.tableView.reloadData()
            return
        }
        self.filteredGroups = self.myGroups?.filter("name CONTAINS[cd] %@", text)
        self.tableView.reloadData()
    }
}
