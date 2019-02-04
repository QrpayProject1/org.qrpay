//
//  ViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/21/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var phoneNum: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if(UserDefaults.standard.bool(forKey: "islogged")){
            print("islogged")
            let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomePage" )
            self.present(vc,animated: true)
            
         
        }*/
    }

    @IBAction func sendCode(_ sender: Any) {
        let alert = UIAlertController(title:"phone number", message:"Telefon Numaranızı Doğru Girdinizmi \n \("+90"+phoneNum.text!)",preferredStyle: .alert)
        let action = UIAlertAction(title: "Evet", style: .default) {
            (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber("+90"+self.phoneNum.text!, uiDelegate: nil) {(verificationID, error) in
            
               
                
                if error != nil {
                    print("error: \(String(describing: error?.localizedDescription))")
                 
                }else {
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    self.performSegue(withIdentifier: "code", sender: Any?.self)
                }
            }
              //UserDefaults.standard.set(self.phoneNum.text!, forKey: "telno")
            //UserDefaults.standard.set(self.phoneNum.text!, forKey: "telno")
            let telnumarası = self.phoneNum.text!
            UserDefaults.standard.set(telnumarası, forKey: "telno")
          
            
            let telll = UserDefaults.standard.object(forKey: "telno")
            print("object  \(telll)")
           // let tel = UserDefaults.standard.integer(forKey: "telno")
          //  print("ınteger  \(tel)")
          //  let tell = UserDefaults.standard.double(forKey: "telno")
          //  print("double  \(tell)")
        }
        
        let cancel = UIAlertAction(title:"No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
     
    
    }
   
}
