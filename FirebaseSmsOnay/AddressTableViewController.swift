//
//  AddressTableViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressTableViewController: UITableViewController {
    var userID=0
    var addressList=[User_Address]()

    override func viewDidLoad() {
        super.viewDidLoad()

       AddressRequest()
          self.tableView.tableFooterView=UIView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addressList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressTableViewCell
         let string=addressList[indexPath.row].Address_Title+addressList[indexPath.row].Address_Country
        let string1=addressList[indexPath.row].Address_County+addressList[indexPath.row].Address_City
        let string2=addressList[indexPath.row].Address_Full_Address+String(addressList[indexPath.row].Address_Post_Code)
        cell?.label_address.text = string+string1+string2
        print("sonadres..\(cell?.label_address.text)")
        
        return cell!
    }
    
    
    func AddressRequest(){
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+String(userID)
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
            
               self.tableView.reloadData();
        
                
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }
    


}
