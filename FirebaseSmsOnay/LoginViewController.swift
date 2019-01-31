//
//  LoginViewController.swift
//  qrpay
//
//  Created by imac1 on 19.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI

class LoginViewController: UIViewController {
    
    var emailcontrol=false
    var passwordcontrol=false
    @IBAction func tf_email(_ sender: Any) {
        if (tf_username.text?.count)!>0{
            emailcontrol=true
        }
        else{
            emailcontrol=false
        }
    }
    
    @IBAction func tf_passwordaction(_ sender: Any) {
        if (tf_password.text?.count)!>=5{
            passwordcontrol=true
        }
        else{
            passwordcontrol=false
        }
    }
    @IBOutlet weak var btn_sign: UIButton!
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var label_mistake: UILabel!
    @IBOutlet weak var tf_password: UITextField!
    var user:User_Credentials = User_Credentials()
    var value2:String=""
    @IBAction func btn_login(_ sender: Any) {
        label_mistake.isHidden=true
        if logincontrol(){
       login()
        }
    }
    
    override func viewDidLoad() {
        btn_sign.buttondesign()
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

user.User_Password="aaaa"
     
    }

    func logincontrol()->Bool{
        if(tf_username.text?.count)!>0{
            if(tf_password.text?.count)!>=5{
                return true
            }
            else{
                label_mistake.text="Kullanıcı adı veya şifre hatalı"
                label_mistake.isHidden=false
                return false
            }
            
        }
        else{
            label_mistake.isHidden=false
            label_mistake.text="Kullanıcı adı veya şifre hatalı"
            return false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
 
    func login()  {
       
        var isLogin:String=""
        let url="http://qrparam.net/User_Credentials/Login/?User_Email="+tf_username.text!+"&User_Password="+tf_password.text!
        print(url)
        Alamofire.request(url,method:.get).validate().responseJSON{
            response in
           
            switch response.result{
                
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                print("success")
                 isLogin=String(json["hata"].stringValue);
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
 
                    print(json["User_Email"].stringValue)
                    UserDefaults.standard.set(self.user.User_ID , forKey: "isLogin")
                    if json["Email_Confirm"].stringValue=="Aktif"{
                        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
                        self.performSegue(withIdentifier: "HomePageSegue", sender: self)
                    }
                    else{
                        let alert = UIAlertController(title:"Hata", message:"Mail Aktivasyonunuzu Gerçekleştirmeniz Gerekiyor",preferredStyle: .alert)
                        let action = UIAlertAction(title: "Tamam", style: .default)
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                    }
                 
                    
                }
                else{
                    
                   
                    self.label_mistake.text="Kullanıcı adı veya şifre hatalı"
                    self.label_mistake.isHidden=false
                
                }
                
            case .failure(let error):
                let alert=UIAlertController(title: "Bağlantı Hatası", message: "Lütfen bilgilerinizi kontrol ederek tekrar giriş yapmayı deneyin", preferredStyle:UIAlertControllerStyle.alert)
                let action=UIAlertAction(title: "Tamam", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated:true,completion: nil )
                print(error)
            }

            
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "HomePageSegue"){
             guard let homvc = segue.destination as? HomeViewController else{return}
           //  homvc.value=self.value2
            print("segue")
            print(self.user.User_Email)
             homvc.user=self.user
        }
    
        
        
    }

}

extension UIButton{
    
    func buttondesign(){
        
        self.layer.cornerRadius=10
        self.backgroundColor=UIColor(red: 144/255, green: 116/255, blue: 255/255, alpha: 1)
        self.layer.borderColor=UIColor.purple.withAlphaComponent(0.8).cgColor
        self.layer.borderWidth=2
        self.layer.shadowColor=UIColor.purple.cgColor
        self.layer.shadowRadius=4
        self.layer.shadowOffset=CGSize(width: 0, height: 0)
        self.layer.shadowOpacity=0.8
    }
    
    
    
    
    
    
    
}








