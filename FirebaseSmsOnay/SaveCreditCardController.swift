//
//  SaveCreditCardController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 23.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SaveCreditCardController: UIViewController {

   
    @IBOutlet weak var label_mistake: UILabel!
    @IBOutlet weak var textfield_nameOnCard: UITextField!
    @IBOutlet weak var textfield_cardName: UITextField!
    @IBOutlet weak var textfield_cardNumber: UITextField!
    @IBOutlet weak var textfield_date: UITextField!
    @IBOutlet weak var textfield_securityCode: UITextField!
    @IBOutlet weak var btn_saveCard: UIButton!
    let creditCard=CreditCard()
    var userID=0
    var control=true
    var charcounter=0
    var spacecounter=0
    var textcard=""
    var securitcode=""
    var infoControl=true
    @IBAction func securityCodeControl(_ sender: Any) {
       
        if (textfield_securityCode.text?.count)!>3{
            textfield_securityCode.text=securitcode
        }
        else{
             securitcode=textfield_securityCode.text!
        }
    }
    @IBAction func entry_cardNumber(_ sender: Any) {
        
        if (textfield_cardNumber.text?.count)!<20{
            textcard=textfield_cardNumber.text!
        if((textfield_cardNumber.text?.count)!>charcounter){
         print("yukarı")
            charcounter+=1
            if charcounter%4==spacecounter&&charcounter<19{
                textfield_cardNumber.text=textfield_cardNumber.text!+" "
                spacecounter+=1
                charcounter+=1
            }
            
        }
        else{
            charcounter-=1
            if(charcounter%5==0&&charcounter>0){
                spacecounter-=1
               
            }
        }
        
      print("\(charcounter)----\(spacecounter)")
        }
        else{
            textfield_cardNumber.text=textcard
        }
    }
    
    @IBAction func btn_saveCard(_ sender: Any) {
        infoControl=true
        setupCreditCard()
        if infoControl{
            SaveCardRequest()
        }
        
    }
    
    @IBAction func entry_lastdate(_ sender: Any) {
        
        if textfield_date.text?.count==2&&control{
            textfield_date.text=textfield_date.text!+"/"
        }
        else if (textfield_date.text?.count)!>2{
            control = false
        }
        else if (textfield_date.text?.count)!<2{
            control = true
        }
        else if(textfield_date.text?.count)!>=7{
            
            textfield_date.text=String((textfield_date.text?.prefix(7))!)
            
        }
       
       
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupCreditCard(){
        
        
        if (textfield_cardName.text?.count)!>0{
            creditCard.Card_Name=textfield_cardName.text!
        } else{infoControl=false;
            label_mistake.isHidden=false
            label_mistake.text="Kart İsmi boş bırakılamaz"
            return}
        
        
        
        if (textfield_nameOnCard.text?.count)!>0{
            creditCard.Credit_Card_Name=textfield_nameOnCard.text!
        }  else{infoControl=false;
            label_mistake.isHidden=false
            label_mistake.text="Kart Üzerindeki İsim boş bırakılamaz"
            return}
        
        
        
        let cardnumber=textfield_cardNumber.text?.replacingOccurrences(of: " ", with: "")
        
        if cardnumber?.count==16{
            if String((textfield_cardNumber.text?.dropFirst(0))!)=="4"{
                
                creditCard.Card_Type="VISA"
                
            }
                
            else if String((textfield_cardNumber.text?.dropFirst(0))!)=="5"{
                
                creditCard.Card_Type="MASTER"
                
            }
            creditCard.Card_Number=cardnumber!
        } else{infoControl=false;
            label_mistake.isHidden=false
            label_mistake.text="Kredi Kartı Numarası 16 Haneli Olmalıdır"
            return}
        
        
        
        if (textfield_date.text?.count)!>6{
            let cardDate = textfield_date.text?.split(separator: "/")
            creditCard.Card_Exprition_Month=String(cardDate![0])
            creditCard.Card_Exprition_Year=String(cardDate![1])
        }else{infoControl=false;
            label_mistake.isHidden=false
            label_mistake.text="Son Kullanım Tarihi (gg/yyyy) şeklinde olmalıdır"
            return}
        
        
     
        if(textfield_securityCode.text?.count==3){
            creditCard.Card_CVV=textfield_securityCode.text!}
        else{infoControl=false;
            label_mistake.isHidden=false
            label_mistake.text="Güvenlik Kodu 3 Haneli Olmalıdır"
            return}
        
       
       
      
      
     
        
      
    }
    func dismissVc(){
        self.navigationController?.popViewController(animated: true)
        
    }
    func SaveCardRequest(){
    
        
        let url="http://qrparam.net/User_Credit_Cards_Info/Insert/?Card_Number="+creditCard.Card_Number+"&Card_Name="+creditCard.Card_Name
        let url2="&Card_Exprition_Month="+creditCard.Card_Exprition_Month+"&Card_Exprition_Year="+creditCard.Card_Exprition_Year+"&Card_Type="+creditCard.Card_Type
        let url3="&Card_CVV="+creditCard.Card_CVV+"&User_ID="+String(userID)
        
        let tempURL=url+url2+url3
        
        let correctURL = tempURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        Alamofire.request(correctURL!,method:.get).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
            case .success(let value):
                 print("Kayıt Başarılı")
                 print(correctURL)
                 let alert = UIAlertController(title: "Başarılı", message: "Kredi kaydı işlemi başarı bir şekilde gerçekleşti", preferredStyle: UIAlertControllerStyle.alert)
                 alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default,  handler: {action in self.dismissVc()}))
                 
                 self.present(alert, animated: true, completion: nil)
               
                let value=JSON(value)
            case .failure(let error):
                 print(error)
            }
            
            
        }
        
        
        
    }
    
  
   

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
