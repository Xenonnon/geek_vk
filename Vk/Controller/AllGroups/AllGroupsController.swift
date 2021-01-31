//
//  AllGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class AllGroupsController: UITableViewController {

    //let allGroups = Groups.makeGroups()
    var allGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        let group = self.allGroups[indexPath.row]
        cell.myGroupName.text = group.name
//        cell.avatar.imageURL = group.logoImage

        return cell
    }
    
}
//    var filteredGroups = [AllGroups]()
//    var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//
//    var filtering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    let searchController = UISearchController(searchResultsController: nil)
//    var allGroupsSections = [AllGroupsSections]()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск..."
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//        let allGroupsDictionary = Dictionary.init(grouping: allGroups) {
//            $0.name.prefix(1)
//        }
//        allGroupsSections = allGroupsDictionary.map { AllGroupsSections(title: String($0.key), items: $0.value) }
//        allGroupsSections.sort { $0.title < $1.title }
//    }
//
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if filtering {
//            return 1
//        }
//        else {
//            return allGroupsSections.count
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if filtering {
//            return filteredGroups.count
//        }
//        else {
//            return allGroupsSections[section].items.count
//        }
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { allGroupsSections.map { $0.title }
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
//        else { return UITableViewCell() }
//        var groups: AllGroups
//        if filtering {
//            groups = filteredGroups[indexPath.row]
//        } else {
//            groups = allGroupsSections[indexPath.section].items[indexPath.row]
//        }
//        cell.myGroupImage.image = groups.image
//        cell.myGroupName.text = groups.name
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15.0))
//        view.backgroundColor = .systemGray5
//        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
//        label.font = UIFont(name: "Scrol", size: 17.0)
//        label.text = allGroupsSections[section].title
//        view.addSubview(label)
//        return view
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}
//
//extension AllGroupsController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//        }
//    func filterContentForSearchText(_ searchText: String) {
//        filteredGroups = allGroups.filter({ (allGroups: AllGroups) -> Bool in
//            return allGroups.name.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//}
