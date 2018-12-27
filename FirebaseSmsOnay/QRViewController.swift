//
//  QRViewController.swift
//  qrpay
//
//  Created by imac1 on 21.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class QRViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var user1 = User_Credentials()
   // var timer: Timer!;
    var isStartQr=false;
    let captureSession = AVCaptureSession()
   


    override func viewDidLoad() {
        super.viewDidLoad()
       print("qr1 \(user1.User_ID)")

       startQr()
    }

   
    
    func startQr(){
        isStartQr=true;
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        /* guard  let inputu = try? AVCaptureDeviceInput(device: captureDevice) else {
         return
         
         }*/
        do{
            //önceki aygıt nesnesini kullanarak AVCaptureDeviceInput sınıfının nir örneği alındı
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //Giriş cihazını yakalama oturumuna ayarla
            captureSession.addInput(input)
            
            //Bir AVCaptureMetadataoutput nesnesini başlatın ve yakalama oturumu içi çıkış aygıtı olarak ayarlayın
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            
            //Delegeyi ayarlayın ve geri aramayı yürütmek için varsayılan gönderi kuyruğunu kullanın
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            
            
            //cihazın kamerası tarafından yakalanan videoyu ekranda görüntülememiz için aşağıdaki kodu ekledik
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
            //QR kodunu vurgulamak için önce bir UIView nesnesi oluşturacağız ve sınırını yeşile ayarlayacağız.
            
            qrCodeFrameView = UIView()
            //UIView nesnesinin boyutu varsayılan olarak sıfır olarak ayarlandığından qrCodeFrameView değişkeni ekranda görünmez. Daha sonra, bir QR kodu algılandığında, boyutunu değiştirir ve yeşil bir kutuya dönüştürürüz.
            print("dış")
            if let qrCodeFrameView = qrCodeFrameView {
                print("iç")
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
                print("bişeyler")
            }
        } catch {
            //herhangi bir hata oluşursa , sadece hatayı yazdırın ve daha fazla devam etmeyin
            print(error)
            return
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
     //   view.bringSubview(toFront:messageLabel)
       // view.bringSubview(toFront:topbar)
        
    }
    //qr kodu tanıdığında bunu çağırır
    //Yöntemin ikinci parametresi (yani metadataObjects), okunan tüm meta veri nesnelerini içeren bir dizi nesnesidir. bu dizinin sıfır olmadığından ve en az bir nesne içerdiğinden emin olmak. Aksi takdirde, qrCodeFrameView boyutunu sıfır olarak sıfırlar ve messageLabel öğesini varsayılan mesajına ayarlarız.
    func metadataOutput(_ output:AVCaptureMetadataOutput, didOutput metadataObjects:[AVMetadataObject],from connection: AVCaptureConnection){
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("qr algılanamadı")
           // messageLabel.text = "QR kodu algılanmadı"
            return
        }
        
        // Meta veri nesnesi
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            //  Bulunan meta veriler, QR kodu meta verilerine eşitse, durum etiketinin metnini güncelleyin ve sınırları ayarlayın.
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            //Son olarak, QR kodun okunabilir bilgilere çözüyoruz.
            // Kodlanan bilgilere bir AVMetadataMachineReadableCode nesnesinin stringValue özelliği kullanılarak erişilebilir.
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
                var value = metadataObj.stringValue
                if((value?.count)!>0){
                    print(value!)
                  
                    var fullNameArr = value?.split(separator: ",")
                    var yeniArr3 = fullNameArr?[0].split(separator: ":")
                    var key:String=String((yeniArr3?[1])!).replacingOccurrences(of: "\"", with: "")
                    if key=="qrpay"{
                       
                    print("dizigelen\(fullNameArr!)")
                    
                    var yeniveriArr = fullNameArr?[2].split(separator: ":")
                    var yeniveriArr1 = fullNameArr?[4].split(separator: ":")
                    var yeniveriArr2 = fullNameArr?[18].split(separator: ":")
                    print(fullNameArr?[4])
                   print(yeniveriArr)
                    var shoppingid:Int = Int(String((yeniveriArr2?[1])!).replacingOccurrences(of: "}", with: ""))!
                    var productname:String = String((yeniveriArr1?[1])!).replacingOccurrences(of: "\"", with: "")
                    let ordercode:Int=Int(String((yeniveriArr?[1])!).replacingOccurrences(of: "\"", with: ""))!
                    print("ordercode\(yeniveriArr?[1])")
                    print("productname\(productname)")
                   
                    print("shopping\(shoppingid)")
                    var userorderinfo=User_Order_Info()
                    userorderinfo.Order_Code=Int(ordercode)
                    userorderinfo.Order_Product_Name=productname
                    userorderinfo.Shopping_Box_ID=shoppingid
                    postUserJson(userordernfo: userorderinfo)
                    }
                  
                  //  print(yeniveriArr)
                 /*   var a = 0
                    for _ in 0...fullNameArr.count{
                    let yeniveriArr = fullNameArr[i].split(separator: ":")
                     
                    print("sonrakidizi\(yeniveriArr)")
                        a += 1
                    //  var Tarih: String = fullNameArr[0]
                    //  var Saat: String = fullNameArr[1]
                    //  print(Saat)
                 
                        //  print(Saat)
                        
                }*/
                    captureSession.stopRunning();
                }
            }
        }}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postUserJson(userordernfo:User_Order_Info){
        
        let url="http://qrparam.net/User_Order_Info/QRKontrol/?Order_Code="+String(userordernfo.Order_Code)+"&Order_Product_Name="+userordernfo.Order_Product_Name
        let url1="&Shopping_Box_ID="+String(userordernfo.Shopping_Box_ID)
        
        let totalurl=url+url1
        
        let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                /*  if json.count>0
                 {
                 let storyboard=UIStoryboard(name: "Main", bundle: nil)
                 let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc")
                 self.present(vc,animated: true,completion: nil);
                 }*/
                
            case .failure(let error):
                print(error)
                
                
                
            }
        }
        
    }
    
}

