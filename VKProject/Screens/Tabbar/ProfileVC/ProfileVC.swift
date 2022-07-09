//
//  ProfileVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    var users: [UserModel] = []
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLastName: UILabel!
    @IBOutlet weak var bdateProfile: UILabel!
    @IBOutlet weak var cityProfile: UILabel!
    @IBOutlet weak var countryProfile: UILabel!
    @IBOutlet weak var aboutProfile: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getUser { [weak self] users in
            guard let self = self else { return }
            self.users = users
            DispatchQueue.main.async {
                self.profileName.text = users[0].firstName
                self.profileLastName.text = users[0].lastName
                self.bdateProfile.text = users[0].bdate
                self.cityProfile.text = users[0].city?.title
                self.countryProfile.text = String(users[0].city?.id ?? 1)
                self.aboutProfile.text = users[0].about
                self.ProfileImage.sd_setImage(with: URL(string: users[0].photo200 ?? ""))
                
            }
        }
        
        
        
    }
    
}
