//
//  PaymentViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 24.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PaymentViewController: UIViewController {
    
//MARK StartVeriables
    @IBOutlet weak var btn_addressChoose: UIButton!
    @IBOutlet weak var btn_cardchoose: UIButton!
    var tapCardChoose=true
    var tapAddressChoose=true
    
    
    //MARK Veriables
     var addressList=[User_Address]()
     var cardList=[CreditCard]()
     var scroolview=UIScrollView()
    
    
    
    @IBAction func btn_chooseAddress(_ sender: Any) {
        
          let y = btn_addressChoose.frame.origin.y+btn_addressChoose.frame.size.height
       
        if tapAddressChoose{
            
            showScroolAddress(x:10, y: Int(y), width: Int(view.frame.width-20), list: addressList)
            tapAddressChoose=false
            tapCardChoose=false
        }
        
        else{
            scroolview.isHidden=true
            tapAddressChoose=true
            tapCardChoose=true
        }
    
    }
    
    @IBAction func btn_chooseCard(_ sender: Any) {
        let y = self.btn_cardchoose.frame.origin.y+self.btn_cardchoose.frame.size.height
        
        if cardList.count>0
        {
            if tapCardChoose{
               self.showScroolCreditCard(x:10, y: Int(y), width: Int(self.view.frame.width-20), list: self.cardList)
            tapCardChoose=false
            tapAddressChoose=false
                    }
            else{
            scroolview.isHidden=true
            tapCardChoose=true
            tapAddressChoose=true
                    }
        }
        else {
            let alert=UIAlertController(title: "Uyarı", message: "Kayıtlı kredi kartı bulunmamaktadır kredi kartı kaydetme sayfasına yönlendirilmek ister misiniz ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
                self.goToRegCardVc()
            }))
            alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))
        }
    }
    func goToRegCardVc(){
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegCreditCard") as! SaveCreditCardController
        self.present(vc,animated:true,completion:nil )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CreditCardRequest()
        AddressRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddressRequest()
        CreditCardRequest()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func showScroolAddress(x:Int,y:Int,width:Int,list:[User_Address]){
        scroolview=UIScrollView()
        scroolview.isHidden=false
        scroolview.frame=CGRect(x: x, y: y, width: width, height: list.count*60)
        scroolview.contentSize=CGSize(width: width, height: list.count*60)
        scroolview.backgroundColor=UIColor.gray
        scroolview.isScrollEnabled=true
        for i in 0..<list.count{
            
            let button = UIButton()
            button.frame=CGRect(x: x, y:10+(i*55), width: width-20, height: 50)
            button.setTitle(String(addressList[i].Address_Title), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(tapToAddressButton(_:)), for: .touchUpInside)
            button.tag=addressList[i].User_Address_ID
            button.backgroundColor=UIColor.white
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
      
        
        self.view.addSubview(scroolview)
    }
    
   @objc func tapToAddressButton(_ sender: UIButton){
    
    for i in 0..<addressList.count{
        
        if Int(addressList[i].User_Address_ID)==sender.tag{
            scroolview.isHidden=true
            btn_addressChoose.setTitle(addressList[i].Address_Title, for: .normal)
            self.tapAddressChoose=true
            self.tapCardChoose=true
        }
        
    }
        
    }
    func showScroolCreditCard(x:Int,y:Int,width:Int,list:[CreditCard]){
        
        scroolview=UIScrollView()
        scroolview.isHidden=false
        scroolview.frame=CGRect(x: x, y: y, width: width, height: list.count*60)
        scroolview.contentSize=CGSize(width: width, height: list.count*100)
        scroolview.backgroundColor=UIColor.gray
        scroolview.isScrollEnabled=true
        for i in 0..<list.count{
            
            let button = UIButton()
            button.frame=CGRect(x: x, y:10+(i*55), width: width-20, height: 50)
            button.setTitle(String(cardList[i].Card_Name), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor=UIColor.white
            button.addTarget(self, action: #selector(tapToCardButton(_:)), for: .touchUpInside)
            button.tag=Int(cardList[i].Cards_ID)!
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
        self.view.addSubview(scroolview)
    }
    
    @objc func tapToCardButton(_ sender: UIButton){
        for i in 0..<cardList.count{
            if Int(cardList[i].Cards_ID)==sender.tag{
                scroolview.isHidden=true
                btn_cardchoose.setTitle(cardList[i].Card_Name, for: .normal)
                self.tapAddressChoose=true
                self.tapCardChoose=true
                break;
            }
        }
    }
    
    func CreditCardRequest(){
        cardList.removeAll()
        let userID=UserDefaults.standard.string(forKey: "userıd")
        let correctUrl="http://qrparam.net/User_Credit_Cards_Info/ListToCard/?User_ID="+userID!
        print(correctUrl)
        Alamofire.request(correctUrl,method:.get).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print("CardJson\(json)")
                
                for i in 0..<json["card"].count{
                    var creditCard=CreditCard()
                    creditCard.Card_CVV=json["card"][i]["Card_CVV"].stringValue
                    creditCard.Card_Exprition_Month=json["card"][i]["Card_Exprition_Month"].stringValue
                    creditCard.Cards_ID=json["card"][i]["Cards_ID"].stringValue
                    creditCard.Card_Exprition_Year=json["card"][i]["Card_Exprition_Year"].stringValue
                    creditCard.Card_Name=json["card"][i]["Card_Name"].stringValue
                    creditCard.Card_Number=json["card"][i]["Card_Number"].stringValue
                    creditCard.Credit_Card_Name=json["card"][i]["Credit_Card_Name"].stringValue
                    creditCard.Card_Type=json["card"][i]["Card_Type"].stringValue
                    print("cardname--\(json["card"][i]["Card_Name"].stringValue)")
                    self.cardList.append(creditCard)
                }
               
                
                case .failure(let error):
                print(error)
            }
            
            
        }
        
    }

    
    
    
    func AddressRequest(){
        let userId = UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+userId!
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        
        Alamofire.request(correctURL!).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
                
            case .success(let value):
                let addressjson=JSON(value)
                print(addressjson)
                print(addressjson.count)
                for i in 0...addressjson.count-1{
                    print(i)
                    let address=User_Address()
                    address.User_Address_ID = addressjson[i]["User_Address_ID"].intValue
                    address.Address_Title = addressjson[i]["Address_Title"].stringValue
                    address.Address_Country = addressjson[i]["Address_Country"].stringValue
                    address.Address_City = addressjson[i]["Address_City"].stringValue
                    address.Address_County = addressjson[i]["Address_County"].stringValue
                    address.Address_Post_Code = addressjson[i]["Address_Post_Code"].intValue
                    address.Address_Full_Address = addressjson[i]["Address_Full_Address"].stringValue
                    address.Address_Invoice_Type = addressjson[i]["Address_Invoice_Type"].stringValue
                    address.User_ID = addressjson[i]["User_ID"].stringValue
                    self.addressList.append(address)
                    
                }
                
               // self.scroolview.reloadData();
                //self.scroolview.reloadInputViews()
              //  self.btn_addressChoose.reloadInputViews()
                
                
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }

}
