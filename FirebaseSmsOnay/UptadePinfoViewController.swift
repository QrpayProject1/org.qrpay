//
//  UptadePinfoViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UptadePinfoViewController: UIViewController {

    
    @IBOutlet weak var label_birdhdate: UILabel!
    @IBOutlet weak var label_phone: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_surname: UILabel!
    @IBOutlet weak var label_name: UILabel!
    
    @IBOutlet weak var btn_cgangepassword: UIButton!
    var user = User_Credentials()
    @IBAction func btn_changepassword(_ sender: Any) {
      
        
        self.performSegue(withIdentifier: "seguepassword", sender: self)
    }
    
    @IBAction func btn_exit(_ sender: Any) {
        /*let alert=UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)*/
        exitVC()
    }
    func exitVC(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
        //navigatıoncontroller olduğu için "dismiss" yerine aşağıdaki kod kullanılır
        //dismiss(animated: true, completion: nil)
      // self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
          btn_cgangepassword.buttondesign()
        print("user\(user.User_Name)")
        fillLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func fillLabel(){
        
        label_name.text=user.User_Name
        label_surname.text=user.User_Surname
        label_email.text=user.User_Email
        label_phone.text=String(user.User_Phone_Number)
        label_birdhdate.text=user.User_Birth_Date
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="seguepassword"{
            guard  let vc = segue.destination as? PasswordChangeViewController else {return}
            vc.password=user.User_Password
            vc.userid=user.User_ID 
        }
    }
    
    
    func UserInfoRequest()
    {
        
        
        let url="http://qrparam.net/User_Credentials/Login/?User_Email="+user.User_Email+"&User_Password="+user.User_Password
        print(url)
        Alamofire.request(url,method:.get).validate().responseJSON{
            response in
            
            switch response.result{
                
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                print("success")
             
                if json.count>0{
                    
                    self.user.User_Email=json["User_Email"].stringValue
                    self.user.User_Credential_Number=json["User_Credential_Number"].intValue
                    self.user.User_Gender = json["User_Gender"].stringValue
                    self.user.User_Phone_Number=json["User_Phone_Number"].intValue
                    self.user.User_Birth_Date=json["User_Birth_Date"].stringValue
                    self.user.User_Name = json["User_Name"].stringValue
                    self.user.User_Surname = json["User_Surname"].stringValue
                    self.user.User_ID = json["User_ID"].intValue
                    self.user.User_Password =  json["User_Password"].stringValue
                    
                }
                
            case .failure(let error):
                print(error)

    

            }
        }
    }
}
