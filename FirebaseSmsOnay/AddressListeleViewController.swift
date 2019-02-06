//
//  AddressListeleViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/29/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressListeleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var SaveAddress: UIButton!
    
    @IBAction func btn_Cıkıs(_ sender: Any) {
        let alert = UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertActionStyle.default, handler: {action in self.exitVC()}))
        self.present(alert,animated: true,completion: nil)
        
    }
    func exitVC(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SaveAddress(_ sender: Any) {
        SaveAddress.buttondesign()
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    var userID=0
    var addressList=[User_Address]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AddressListeleTableViewCell
        let string=addressList[indexPath.row].Address_Title+"\n"+addressList[indexPath.row].Address_Country
        let string1=addressList[indexPath.row].Address_County+"\n"+addressList[indexPath.row].Address_City
        let string2=addressList[indexPath.row].Address_Full_Address+"\n"+String(addressList[indexPath.row].Address_Post_Code)
        cell?.adress_lbl.text = string+string1+string2
        print("sonadres..\(cell?.adress_lbl.text)")
        cell!.viewcell.layer.cornerRadius=5
        cell!.viewcell.layer.borderWidth=2
        cell!.viewcell.layer.borderColor=UIColor.darkGray.cgColor
        cell!.viewcell.layer.backgroundColor=UIColor.darkGray.cgColor
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        AddressRequest();

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
                if(addressjson.count>0){
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
                print("gfgyudytdrdrtsas")
                self.tableview.reloadData()
                
                }else{
                    let alert = UIAlertController(title: "", message: "Kayıtlı Adresiniz bulunmamaktadır.Adres Kaydetmek istermisiniz?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,  handler: {action in self.CancelAddress()}))
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default,  handler: {action in self.saveAdres()}))
                   
                    self.present(alert, animated: true, completion: nil)
                }
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }
    func saveAdres(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
       
    }
    func CancelAddress(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
    }
    

}
