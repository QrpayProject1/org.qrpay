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
    @IBAction func btn_changepassword(_ sender: Any) {
        
        self.performSegue(withIdentifier: "seguepassword", sender: self)
    }
    var user = User_Credentials()
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
