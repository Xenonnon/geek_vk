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
    
    var myGroups = try? Realm().objects(Group.self) {
        didSet {
            self.filteredGroups = self.convertToArray(results: self.myGroups)
            self.tableView.reloadData()
        }
    }
    
    var filteredGroups = [Group]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsController,
            let indexPath = controller.tableView.indexPathForSelectedRow,
            !self.convertToArray(results: self.myGroups).contains(where: {$0.name == controller.allGroups[indexPath.row].name})
        else { return }
        
        let group = controller.allGroups[indexPath.row]
        var newGroupList = self.convertToArray(results: self.myGroups)
        newGroupList.append(group)
        try? RealmServce.save(items: newGroupList)
        self.filteredGroups.append(group)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchBar.delegate = self
        self.filteredGroups = self.convertToArray(results: self.myGroups)
        tableView.rowHeight = 60
        
        let networkService = NetworkService()
        networkService.getUserGroups() { [] groups in
//            self?.myGroups = groups
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        
        let group = self.filteredGroups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = self.filteredGroups.remove(at: indexPath.row)
            if let index = self.convertToArray(results: self.myGroups).firstIndex(of: removed) {
                var newGroupList = self.convertToArray(results: self.myGroups)
                newGroupList.remove(at: index)
                try? RealmServce.save(items: newGroupList)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
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
            self.filteredGroups = self.convertToArray(results: self.myGroups)
            self.tableView.reloadData()
            return
        }
        self.filteredGroups = self.convertToArray(results: self.myGroups).filter {$0.name.lowercased().contains(text.lowercased())}
        self.tableView.reloadData()
    }
}

extension MyGroupsController {
    private func convertToArray <T>(results: Results<T>?) -> [T] {
        guard let results = results else { return [] }
        return Array(results)
    }
}
