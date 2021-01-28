//
//  MyGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class MyGroupsController: UITableViewController {

    //var myGroups = [String]()
    //var myGroupsImages = [UIImage]()
    
    var myGroups = [Group]() {
        didSet {
            self.filteredGroups = self.myGroups
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
            !self.myGroups.contains(where: {$0.name == controller.allGroups[indexPath.row].name})
        else { return }
        
        let group = controller.allGroups[indexPath.row]
        self.myGroups.append(group)
        self.filteredGroups.append(group)
        tableView.reloadData()
    }

//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        guard
//            segue.identifier == "addGroup",
//            let controller = segue.source as? AllGroupsController,
//            let indexPath = controller.tableView.indexPathForSelectedRow,
//
//            !myGroups.contains(controller.allGroupsSections[indexPath.section].items[indexPath.row].name)
//            //!myGroups.contains(controller.allGroups[indexPath.row].name)
//        else { return }
//        let group = controller.allGroupsSections[indexPath.section].items[indexPath.row]
//        //let group = controller.allGroups[indexPath.row]
//
//        myGroups.append(group.name)
//        myGroupsImages.append(group.image!)
//        tableView.reloadData()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mySerachBar.delegate = self
        self.filteredGroups = myGroups
        tableView.rowHeight = 60
        
        let networkService = NetworkService()
        networkService.getUserGroups() { [weak self] groups in
            self?.myGroups = groups
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
        cell.myGroupName.text = group.name
        cell.groupImageView.imageURL = group.photo100

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = self.filteredGroups.remove(at: indexPath.row)
            if let index = self.myGroups.firstIndex(of: removed) {
                self.myGroups.remove(at: index)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroups.remove(at: indexPath.row)
//            myGroupsImages.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//
//
//    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        myGroups.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
//        else { return UITableViewCell() }
//        cell.myGroupName.text = myGroups[indexPath.row]
//        cell.myGroupImage.image = myGroupsImages[indexPath.row]
//
//        return cell
//    }

}
