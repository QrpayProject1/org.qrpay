//
//  SaveAddressViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/22/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SaveAddressViewController: UIViewController {

    
    
    @IBOutlet weak var Addresstitle: UITextField!
    @IBOutlet weak var AddressCountry: UITextField!
    @IBOutlet weak var AddressCity: UITextField!
    @IBOutlet weak var AddressCounty: UITextField!
    
    @IBOutlet weak var AddressFullAddress: UITextView!
    @IBOutlet weak var AddressPostCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SaveAddressbtn(_ sender: Any) {
        let user=getAddressInfo();
        postUserJson(user: user)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getAddressInfo() -> User_Address{
        
        let user=User_Address()
        
        if let ATitle=Addresstitle.text { user.Address_Title=ATitle}
        
        if let ACountry=AddressCountry.text {user.Address_Country=String(ACountry)}
        
        if let ACity=AddressCity.text {
          
           user.Address_City=String(ACity)
            }
        
        
        if let ACounty=AddressCounty.text {
            user.Address_County=ACounty
        }
        
        if let AFullAddress=AddressFullAddress.text {
            user.Address_Full_Address=AFullAddress
        }
        
        if let APostCode=AddressPostCode.text {user.Address_Post_Code=Int(APostCode)!}
        
        
      
        
        return user;
        
    }
    func saveVc(){
       /* let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Addreslistele") as! AddressListeleViewController
        self.present(vc, animated: true, completion: nil)*/
         dismiss(animated: true, completion: nil)
    }
    
    func postUserJson(user:User_Address){
        print(user.Address_County)
       let userıd = UserDefaults.standard.string(forKey: "userıd")
      
        let url="http://qrparam.net/User_Address_Info/Insert/?Address_Title="+user.Address_Title+"&Address_Country="+user.Address_Country
        let url2="&Address_City="+user.Address_City+"&Address_County="+user.Address_County
        let url3="&Address_Post_Code="+String(user.Address_Post_Code)+"&Address_Full_Address="+user.Address_Full_Address
        let url4="&Address_Invoice_Type=4&User_ID=30268"
        
        let totalurl=url+url2+url3+url4
        
        let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                if json.count>0
                {
                   
                    let alert = UIAlertController(title: "Başarılı", message: "Adresiniz Kaydedilmiştir", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.saveVc()}))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
