//
//  MyGroupsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class MyGroupsController: UITableViewController {

    var myGroups = [String]()
<<<<<<< HEAD
=======
    var myGroupsImages = [UIImage]()
    
>>>>>>> v4
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsController,
            let indexPath = controller.tableView.indexPathForSelectedRow,
<<<<<<< HEAD
            !myGroups.contains(controller.allGroups[indexPath.row])
        else { return }
        let group = controller.allGroups[indexPath.row]
        myGroups.append(group)
=======
            !myGroups.contains(controller.allGroups[indexPath.row].name)
        else { return }
        let group = controller.allGroups[indexPath.row]
        myGroups.append(group.name)
        myGroupsImages.append(group.image!)
>>>>>>> v4
        tableView.reloadData()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
<<<<<<< HEAD
            tableView.deleteRows(at: [indexPath], with: .left)
=======
            myGroupsImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
>>>>>>> v4
        }
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
<<<<<<< HEAD
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else { return UITableViewCell() }
        cell.myGroupName.text = myGroups[indexPath.row]
        cell.myGroupImage.image = UIImage(named: "darth-vader")
=======
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        cell.myGroupName.text = myGroups[indexPath.row]
        cell.myGroupImage.image = myGroupsImages[indexPath.row]
>>>>>>> v4

        return cell
    }

}
