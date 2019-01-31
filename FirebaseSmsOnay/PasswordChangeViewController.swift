//
//  PasswordChangeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PasswordChangeViewController: UIViewController {
    
    var password=""
    var userid=0
    @IBOutlet weak var label_error: UILabel!
    @IBAction func btn_change(_ sender: Any) {
        
        checkCurrentPasssword()
        
    }
    @IBOutlet weak var newpasswordagain: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var currentpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    func checkCurrentPasssword() {
        let url = "http://qrparam.net/User_Credentials/PasswordControl/?User_ID="+String(userid)+"&User_Password="+password
        let correctURL=url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed )
        
        Alamofire.request(correctURL!).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json = JSON(value)
                if json.count>0{
                    if self.newpassword.text==self.newpasswordagain.text{
                        self.sendNewPassRequest(newpassword: self.newpasswordagain.text!)
                    }
                    else{
                        self.label_error.text="Yeni şifre eşleşmedi"
                    }
                }
                else{
                    self.label_error.text="Mevcut Şifre Hatalı"
                }
            case .failure(let error):
                self.label_error.text="Bağlantı Hatası..."
              
                
            }
            
            
        }
        
    }
    
    
    func sendNewPassRequest(newpassword:String){
        
        let url = "http://qrparam.net/User_Credentials/ChangePassword/?User_ID="+String(userid)+"&User_Password="+newpassword
        
        Alamofire.request(url).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case.success(let value):
                let json=JSON(value)
                
                if(json["User_Password"].stringValue==newpassword){
                    self.turnSettings()
                }
                else {
                    print(json["user_password"].stringValue)
                }
                
            case .failure(let error):
                print(error)
                
        }
        
        
    }

}

    
    func turnSettings()
    {
       navigationController?.popViewController(animated: true)
        
    }


}



