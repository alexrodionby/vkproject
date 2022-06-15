//
//  GroupsVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 3.06.22.
//

import UIKit
import SDWebImage
import RealmSwift

class GroupsVC: UIViewController {
    
    @IBOutlet weak var groupsTable: UITableView!
    
    var groups: [GroupDAO] = []
    var groupsDatabase = GroupsDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let groupsFromDB = Array(groupsDatabase.fetch())
        
        if groupsFromDB.count > 0 {
            self.groups = groupsFromDB
            self.groupsTable.reloadData()
            
        } else {
            
            APIManager.shared.getGroups { [weak self] groups in
                guard let self = self else { return }
                self.groups = groups
                self.groupsDatabase.save(groups)
                DispatchQueue.main.async {
                    print("Релоадит дату в таблице")
                    self.groupsTable.reloadData()
                }
            }
        }
    }
}

extension GroupsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Сколько строк в таблице = ", groups.count)
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupName.text = String(groups[indexPath.row].name ?? "")
        cell.groupsImage.sd_setImage(with: URL(string: groups[indexPath.row].photo200 ?? ""))
        cell.groupMembers.text = String(groups[indexPath.row].membersCount ?? 123)
        cell.groupCountry.text = String(groups[indexPath.row].country?.title ?? "Нет страны")
        cell.groupCity.text = String(groups[indexPath.row].city?.title ?? "Нет города")
        cell.groupSite.text = String(groups[indexPath.row].site ?? "Нет сайта")
        cell.groupDiscription.text = String(groups[indexPath.row].itemDescription ?? "Нет описания")
        return cell
    }
    
    
    
}
