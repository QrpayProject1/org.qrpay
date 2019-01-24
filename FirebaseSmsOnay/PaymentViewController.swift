//
//  PaymentViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 24.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    

    @IBOutlet weak var btn_addressChoose: UIButton!
    @IBOutlet weak var btn_cardchoose: UIButton!
    var tapCardChoose=true
    var tapAddressChoose=true
    let listcard = ["Garanti","Ziraat","YapıKredi","CardFinans"]
    let listAddres = ["Ev","İşyeri","Ev2","İşyeriMaslak"]
     var scroolview = UIScrollView()
    
    @IBAction func btn_chooseAddress(_ sender: Any) {
          let y = btn_addressChoose.frame.origin.y+btn_addressChoose.frame.size.height
        if tapAddressChoose{
      
            showScrool(x:10, y: Int(y), width: Int(view.frame.width-20), list: listAddres)
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
              showScrool(x:10, y: Int(y), width: Int(view.frame.width-20), list: listcard)
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

       
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func showScrool(x:Int,y:Int,width:Int,list:[String]){
        
        scroolview.isHidden=false
        scroolview.frame=CGRect(x: x, y: y, width: width, height: list.count*60)
        scroolview.contentSize=CGSize(width: width, height: list.count*60)
        scroolview.backgroundColor=UIColor.gray
        scroolview.isScrollEnabled=true
        for i in 0..<list.count{
            
            let button = UIButton()
            button.frame=CGRect(x: x, y:10+(i*55), width: width-20, height: 50)
            button.setTitle(list[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor=UIColor.white
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
        self.view.addSubview(scroolview)
    }

    
    

}
