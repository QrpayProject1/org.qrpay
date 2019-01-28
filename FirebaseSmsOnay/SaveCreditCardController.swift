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

   
    @IBOutlet weak var textfield_nameOnCard: UITextField!
    @IBOutlet weak var textfield_cardName: UITextField!
    @IBOutlet weak var textfield_cardNumber: UITextField!
    @IBOutlet weak var textfield_date: UITextField!
    @IBOutlet weak var textfield_securityCode: UITextField!
    @IBOutlet weak var btn_saveCard: UIButton!
    let creditCard=Credit_Card()
    var userID=0
    
    @IBAction func entry_cardNumber(_ sender: Any) {
        
        
        
    }
    @IBAction func btn_saveCard(_ sender: Any) {
        
        
    }
    
    @IBAction func entry_lastdate(_ sender: Any) {
        
        if textfield_date.text?.count==2{
            textfield_date.text=textfield_date.text!+"/"
        }
       
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupCreditCard(){
        
        if String((textfield_cardNumber.text?.dropFirst(0))!)=="4"{
            
            creditCard.Card_Type="VISA"
            
        }
            
        else if String((textfield_cardNumber.text?.dropFirst(0))!)=="5"{
            
            creditCard.Card_Type="MASTER"
            
        }
        creditCard.Card_CVV=textfield_securityCode.text!
        creditCard.Card_Number=textfield_cardNumber.text!
        creditCard.Card_Name=textfield_cardName.text!
        creditCard.Credit_Card_Name=textfield_nameOnCard.text!
        let cardDate = textfield_date.text?.split(separator: "/")
        creditCard.Card_Exprition_Month=String(cardDate![0])
        creditCard.Card_Exprition_Year=String(cardDate![1])
        
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
            case .failure(let error):
                 print(error)
            }
            
            
        }
        
        
        
    }
    
   

}
