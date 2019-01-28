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
    

    @IBOutlet weak var btn_addressChoose: UIButton!
    @IBOutlet weak var btn_cardchoose: UIButton!
    var tapCardChoose=true
    var tapAddressChoose=true
    let listcard = ["Garanti","Ziraat","YapıKredi","CardFinans"]
    let listAddres = ["Ev","İşyeri","Ev2","İşyeriMaslak"]
    var scroolview = UIScrollView()
    
     var addressList=[User_Address]()
    
    
    
    
    
    @IBAction func btn_chooseAddress(_ sender: Any) {
        
          let y = btn_addressChoose.frame.origin.y+btn_addressChoose.frame.size.height
        if tapAddressChoose{
            
            showScrool(x:10, y: Int(y), width: Int(view.frame.width-20), list: addressList )
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
         let y = btn_cardchoose.frame.origin.y+btn_cardchoose.frame.size.height
        if tapCardChoose{
             // showScrool(x:10, y: Int(y), width: Int(view.frame.width-20), list: listcard)
            tapCardChoose=false
            tapAddressChoose=false
        }
        else{
            scroolview.isHidden=true
            tapCardChoose=true
            tapAddressChoose=true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        AddressRequest();
       
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func showScrool(x:Int,y:Int,width:Int,list:[User_Address]){
        
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
            button.backgroundColor=UIColor.white
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
        self.view.addSubview(scroolview)
    }

    
    
    
    func AddressRequest(){
        let userıd = UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+userıd!
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
