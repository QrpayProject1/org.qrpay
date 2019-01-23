//
//  SettingsViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var user = User_Credentials()
    @IBOutlet weak var btn_uptadeAddress: UIButton!
    @IBAction func btn_updateAddress(_ sender: Any) {
        
        self.performSegue(withIdentifier: "sequeaddress", sender: self)
        
    }
    
    @IBAction func btn_uptadeinfo(_ sender: Any) {
        
       self.performSegue(withIdentifier: "UpdatePinfo", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "UpdatePinfo"{
            guard let vc = segue.destination as? UptadePinfoViewController else {return}
            vc.user = self.user
        }
        else if segue.identifier == "sequeaddress"{
            guard let vc = segue.destination as? AddressTableViewController else {return}
            vc.userID=user.User_ID
        }
        
    }

    
    

}
