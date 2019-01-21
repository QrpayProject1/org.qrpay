//
//  TableViewController.swift
//  MarketApi
//
//  Created by imac1 on 5.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var myIndex=0
class TableViewController: UITableViewController {

    
    var UserorderInfolist = [User_Order_Info]();
    var user2 = User_Credentials()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        print("userıd \(user2.User_ID)")
        getData();
        
        self.tableView.tableFooterView=UIView();
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserorderInfolist.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! TableViewCell
        print("listecount \(UserorderInfolist.count)")
        print("cell\(UserorderInfolist[indexPath.row].Order_Date)")
        cell.Ordercode.text=String(UserorderInfolist[indexPath.row].Order_Code);
        cell.Orderdate.text=UserorderInfolist[indexPath.row].Order_Date;
        cell.OrderStatus.text=String(UserorderInfolist[indexPath.row].Order_Status);
        cell.OrderWebSite.text=String(UserorderInfolist[indexPath.row].Order_Web_Site);
        let ordercode=cell.Ordercode.text
        UserDefaults.standard.set(ordercode, forKey: "ordercode")
        
        cell.SiparişDetay.tag=indexPath.row
        

        cell.SiparişDetay.addTarget(self, action: #selector(methodname), for: .touchUpInside)
        

        return cell
    }
    //String(user2.User_ID)
    
    @objc func methodname()
    {
        //your function code
        print("tıklandı")
    }
    func getData(){
        let UserorderInfo = User_Order_Info()
        Alamofire.request("http://qrparam.net/User_Order_Info/GecmisSiparisler/?User_ID=30268", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json.count > 0{
                    print(json)
                    for index in 0...json.count-1{
                        print("index \(index)")
                        
                        UserorderInfo.Order_ID=json[index]["Order_ID"].intValue
                        UserorderInfo.Order_Code=json[index]["Order_Code"].intValue
                        UserorderInfo.Order_Date=json[index]["Order_Date"].stringValue
                        UserorderInfo.Order_Product_Name=json[index]["Order_Product_Name"].stringValue
                        UserorderInfo.Order_Status=json[index]["Order_Status"].intValue
                        UserorderInfo.Order_Unit=json[index]["Order_Unit"].stringValue
                        UserorderInfo.Order_Unit_Price=json[index]["Order_Unit_Price"].stringValue
                        UserorderInfo.Order_Product_Amount=json[index]["Order_Product_Amount"].intValue
                        UserorderInfo.Order_Product_Tax_Ratio=json[index]["Order_Product_Tax_Ratio"].stringValue
                        UserorderInfo.Order_Product_Tax_Price=json[index]["Order_Product_Tax_Price"].stringValue
                        UserorderInfo.Order_Product_Price=json[index]["Order_Product_Price"].stringValue
                        UserorderInfo.Order_Shipping_Price=json[index]["Order_Shipping_Price"].floatValue
                        UserorderInfo.Order_Total_Price=json[index]["Order_Total_Price"].floatValue
                        UserorderInfo.Order_Payment_Method=json[index]["Order_Payment_Method"].stringValue
                        UserorderInfo.Shopping_Box_ID=json[index]["Shopping_Box_ID"].intValue
                        UserorderInfo.Order_Web_Site=json[index]["Order_Web_Site"].stringValue
                        self.UserorderInfolist.append(UserorderInfo)
                        print(UserorderInfo.Order_Product_Name)
                        
                    }
                    
                    self.tableView.reloadData();
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "Siparisiceriksegue"){
            guard let qrvc = segue.destination as? SiparisTableViewController else{return}
            //   qrvc.value=self.value2
            //print("qrsegue")
            print("homepace ıd \(self.user2.User_ID)")
            qrvc.user4=self.user2
        }
        
    }
    
}





