//
//  ViewController.swift
//  AnalyticOnline
//
//  Created by Erdogan on 3.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import Alamofire
import Lottie
class ViewController: UIViewController {
var timer: Timer?
var online = ""
    @IBOutlet weak var onlineTextView: UILabel!
    @IBOutlet weak var animationLottie: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        // Do any additional setup after loading the view.
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            self.autoOnlineUser()
            print("working")

        })
        /*self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            AF.request("http://iserteknik.webfirmam.com.tr/analytic/index.php").responseJSON { response in
                
                
                
                switch response.result {
                case let .success(value):
                    //print("JSON: \(value)")
                    if let JSON = value as? [String: Any] {
                        self.online = JSON["online"] as! String
                        self.onlineTextView.text = self.online

                        print(self.online)
                    }
                case let .failure(error): print("error",error)
                }
            }
        })*/
        //self.onlineTextView.text = online

       
    }
  
    func startAnimation(){
        animationLottie.animation = Animation.named("loading")
        //animationLottie.contentMode = UIView.ContentMode.scaleAspectFit
        animationLottie.loopMode = LottieLoopMode.loop
        
        animationLottie.play()
    }
    
    @IBAction func onlineButtonClicked(_ sender: Any) {
        //info pliste allow arbitrary ekle
        
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/analytic/index.php")
        let session = URLSession.shared
        let task = 	session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                
            }else {
                if data != nil {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as!
                        Dictionary<String , AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jsonResult)
                            let online = jsonResult["online"] as! String
                            print(online)
                            self.onlineTextView.text = "Online: \(online)"
                        }
                    }catch {
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func autoOnlineUser(){
        //info pliste allow arbitrary ekle
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/analytic/index.php")
        let session = URLSession.shared
        let task =     session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                
            }else {
                if data != nil {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as!
                            Dictionary<String , AnyObject>
                        
                        DispatchQueue.main.async {
                            //print(jsonResult)
                            let online = jsonResult["online"] as! String
                            self.onlineTextView.text = "Online Auto: \(online)"


                            //print(online)
                        }
                    }catch {
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    func kitle(){
    
    }
}

