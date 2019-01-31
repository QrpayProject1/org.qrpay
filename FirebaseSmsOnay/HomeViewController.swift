//
//  HomeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/26/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
 
    
    @IBOutlet weak var btn_qrRead: UIButton!
    @IBOutlet weak var btn_orders: UIButton!
    @IBOutlet weak var btn_settings: UIButton!
    @IBOutlet weak var btn_address: UIButton!
    
    
    var user=User_Credentials()
    var value:String?
    var degisken=true;
    @IBAction func QrOpen(_ sender: Any) {
        
      self.performSegue(withIdentifier: "qrsegue", sender: self)
        
        
    }
    @IBAction func OpenSettings(_ sender: Any) {
        
        self.performSegue(withIdentifier: "settingsegue", sender: self)
    }
    
    @IBAction func btncıkıs(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnSiparisler(_ sender: Any) {
        
        self.performSegue(withIdentifier: "Siparissegue", sender: self)
    }
    
    
    @IBAction func Address(_ sender: Any) {
       /* let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)*/
       /* let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Addreslistele") as! AddressListeleViewController
        self.present(vc, animated: true, completion: nil)*/
    }
    override func viewDidLoad() {
      
    super.viewDidLoad()
        btn_orders.buttondesign()
        btn_address.buttondesign()
        btn_settings.buttondesign()
        btn_qrRead.buttondesign()
        
         UserDefaults.standard.set(user.User_ID, forKey: "userıd")
        if UserDefaults.standard.value(forKey: "isLogin") != nil {
            
         
        }
        print("home\(user.User_Email)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "qrsegue"){
            guard let qrvc = segue.destination as? QRViewController else{return}
         //   qrvc.value=self.value2
            print("qrsegue")
           print("homepace ıd \(self.user.User_ID)")
            qrvc.user1=self.user
        }
        else if(segue.identifier == "Siparissegue"){
            guard let vc = segue.destination as? TableViewController else{return}
            //   qrvc.value=self.value2
            print("homepace ıd \(self.user.User_ID)")
            vc.user2=self.user
    }
        else if (segue.identifier == "settingsegue"){
            
            guard let vc = segue.destination as? SettingsViewController else{return}
           
            vc.user = self.user
    }
    


    
}
   
}








