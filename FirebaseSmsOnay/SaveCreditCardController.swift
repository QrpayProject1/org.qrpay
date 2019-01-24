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
    
    func SaveCardRequest(){
        
        let url = ""
        
        
    }
    
   

}
