//
//  HomeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/26/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var QrOpen: UIButton!
    var user=User_Credentials()
    var value:String?
    @IBAction func QrOpen(_ sender: Any) {
        // self.performSegue(withIdentifier: "qrsegue", sender: self)
        let  storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QRView") as! QRViewController
       
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        self.performSegue(withIdentifier: "qrsegue", sender: self)
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "qrsegue"){
            guard let qrvc = segue.destination as? QRViewController else{return}
         //   qrvc.value=self.value2
            print("qrsegue")
           print(self.user.User_Email)
            qrvc.user1=self.user
        }
    
}

}
