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
        
        self.performSegue(withIdentifier: "Addresslistele", sender: self)
        
    }
    
    @IBAction func btn_uptadeinfo(_ sender: Any) {
        
       self.performSegue(withIdentifier: "UpdatePinfo", sender: self)
        
    }
    
    
    @IBAction func SavenewAddress(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
        
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
        else if segue.identifier == "Addresslistele"{
            guard let vc = segue.destination as? AddressListeleViewController else {return}
            vc.userID=user.User_ID
        }
        
    }

    
    

}
