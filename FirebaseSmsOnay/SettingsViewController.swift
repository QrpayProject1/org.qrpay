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
    @IBOutlet weak var btn_uptadeinfo: UIButton!
    @IBOutlet weak var btn_register_CreditCard: UIButton!
    
    @IBOutlet weak var SavenewAddress: UIButton!
    @IBAction func btn_updateAddress(_ sender: Any) {
        btn_uptadeAddress.buttondesign()
        
        self.performSegue(withIdentifier: "Addresslistele", sender: self)
        
    }
    
    @IBAction func btn_register_CreditCard(_ sender: Any) {
        btn_register_CreditCard.buttondesign()
        
        self.performSegue(withIdentifier: "segueRegCard", sender: self)
    
    }
    @IBAction func btn_uptadeinfo(_ sender: Any) {
        btn_uptadeinfo.buttondesign()
        
       self.performSegue(withIdentifier: "UpdatePinfo", sender: self)
        
    }
    
    
    @IBAction func SavenewAddress(_ sender: Any) {
        SavenewAddress.buttondesign()
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_exit(_ sender: Any) {
        
       /* let alert=UIAlertController(title: "Çıkış", message: "Çıkış yapmak istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)*/
        exitVC()
    }
    func exitVC(){
        self.navigationController?.popViewController(animated: true)
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
        else if segue.identifier == "segueRegCard"{
            guard let vc = segue.destination as? SaveCreditCardController else{return}
            vc.userID=user.User_ID
        }
        
    }

    
    

}
