//
//  SiparisTableViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/14/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SiparisTableViewController: UITableViewController {
  // var user4 = User_Order_Info()
    var UserorderInfoİceriklist = [User_Order_Info]();
    var UserOrderInfoAddresslist = [User_Address]();
     var user4 = User_Credentials()
    let navigationBar=0;
    let address:String=""
    var labell:UILabel=UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData2();
        
        
        let ordercode=UserDefaults.standard.string(forKey: "ordercode")
         print("orderdegeri....\(ordercode)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
  print("siparişcelliçi\(user4.User_ID)")
   
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView:UITableView,viewForHeaderInSection section: Int)
        -> UIView? {
     
            let view = UIView()
           // let labell=UILabel()
            let firstFrame = CGRect(x: 0, y: 0, width:tableView.frame.width, height: 100)
           
           // view.backgroundColor=UIColor.orange
            labell.backgroundColor=UIColor.orange
            labell.frame = firstFrame
            labell.numberOfLines = 0
            view.addSubview(labell)
           // view.addSubview(label2)
            return view
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserorderInfoİceriklist.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "SiparisMainCell", for: indexPath) as! SiparisTableViewCell
        print("listecount \(UserorderInfoİceriklist.count)")
        
        
        print("cell\(UserorderInfoİceriklist[indexPath.row].Order_Product_Name)")
        cell.OrderCode.text=String(UserorderInfoİceriklist[indexPath.row].Order_Code);
        cell.OrderProductName.text=UserorderInfoİceriklist[indexPath.row].Order_Product_Name;
        cell.OrderUnitPrice.text=String(UserorderInfoİceriklist[indexPath.row].Order_Unit_Price);
        cell.OrderPaymentMethod.text=UserorderInfoİceriklist[indexPath.row].Order_Payment_Method;
        cell.OrderTotalPrice.text=String(UserorderInfoİceriklist[indexPath.row].Order_Total_Price);
        
        
        return cell
    }

    func getData2(){
        let UserorderInfoİcerik = User_Order_Info()
        let UserorderInfoAddress = User_Address()
        Alamofire.request("http://qrparam.net/User_Order_Info/GecmisSiparislerIcerik/?Order_Code=5&User_ID=20107", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if json.count > 0{
                   
                
                    print(json)
                    for index in 0...json.count-1{
                        print("index \(index)")
                        
                        UserorderInfoİcerik.Order_ID=json["list"][index]["Order_ID"].intValue
                        UserorderInfoİcerik.Order_Code=json["list"][index]["Order_Code"].intValue
                        UserorderInfoİcerik.Order_Date=json["list"][index]["Order_Date"].stringValue
                        UserorderInfoİcerik.Order_Product_Name=json["list"][index]["Order_Product_Name"].stringValue
                        UserorderInfoİcerik.Order_Status=json["list"][index]["Order_Status"].intValue
                        UserorderInfoİcerik.Order_Unit=json["list"][index]["Order_Unit"].stringValue
                        UserorderInfoİcerik.Order_Unit_Price=json["list"][index]["Order_Unit_Price"].stringValue
                        UserorderInfoİcerik.Order_Product_Amount=json["list"][index]["Order_Product_Amount"].intValue
                        UserorderInfoİcerik.Order_Product_Tax_Ratio=json["list"][index]["Order_Product_Tax_Ratio"].stringValue
                        UserorderInfoİcerik.Order_Product_Tax_Price=json["list"][index]["Order_Product_Tax_Price"].stringValue
                        UserorderInfoİcerik.Order_Product_Price=json["list"][index]["Order_Product_Price"].stringValue
                        UserorderInfoİcerik.Order_Shipping_Price=json["list"][index]["Order_Shipping_Price"].floatValue
                        UserorderInfoİcerik.Order_Total_Price=json["list"][index]["Order_Total_Price"].floatValue
                        UserorderInfoİcerik.Order_Payment_Method=json["list"][index]["Order_Payment_Method"].stringValue
                        UserorderInfoİcerik.Shopping_Box_ID=json["list"][index]["Shopping_Box_ID"].intValue
                        UserorderInfoİcerik.Order_Web_Site=json["list"][index]["Order_Web_Site"].stringValue
                        UserorderInfoAddress.User_Address_ID=json["addr"][index][" User_Address_ID"].intValue
                        UserorderInfoAddress.Address_Title=json["addr"][index]["Address_Title"].stringValue
                        UserorderInfoAddress.Address_Country=json["addr"][index]["Address_Country"].stringValue
                        UserorderInfoAddress.Address_City=json["addr"][index]["Address_City"].stringValue
                        UserorderInfoAddress.Address_County=json["addr"][index]["Address_County"].stringValue
                        UserorderInfoAddress.Address_Post_Code=json["addr"][index]["Address_Post_Code"].intValue
                        UserorderInfoAddress.Address_Full_Address=json["addr"][index]["Address_Full_Address"].stringValue
                        UserorderInfoAddress.Address_Invoice_Type=json["addr"][index]["Address_Invoice_Type"].stringValue
        
                        self.UserorderInfoİceriklist.append(UserorderInfoİcerik)
                        self.UserOrderInfoAddresslist.append(UserorderInfoAddress)
                        // var User_ID:Int = 0
                        print(UserorderInfoİcerik.Order_ID)
                        print(UserorderInfoİcerik.Order_Product_Name)
                      // let address=UserorderInfoİceriklist.Address_Title
                     //   print("içerde\(address)")
                        
                    }
                    
                    let string1=self.UserOrderInfoAddresslist[0].Address_Title
                    let string2=self.UserOrderInfoAddresslist[0].Address_Full_Address
                    let string3=self.UserOrderInfoAddresslist[0].Address_County+"/"+self.UserOrderInfoAddresslist[0].Address_City+"/"+self.UserOrderInfoAddresslist[0].Address_Country
                    let string4=self.UserOrderInfoAddresslist[0].Address_Post_Code
                    self.labell.text="Adres Başlığı:"+string1+"\n"+"Adress:"+string2+"\n"+string3+"/"+String(string4)
                    //string1+string2+string3+String(string4)
                    self.tableView.reloadData();
                    
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }

}
