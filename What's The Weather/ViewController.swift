//
//  ViewController.swift
//  What's The Weather
//
//  Created by Abdoul Wane on 1/15/15.
//  Copyright (c) 2015 Abdoul Wane. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

   
    
    var urlPrefix = "/forecasts/latest"
    
    
    
    @IBOutlet var city: UITextField!
    
   
    @IBOutlet var Weather: UILabel!
    
    @IBAction func getWeatherButton(sender: AnyObject) {
        
        self.view.endEditing(true)
        
            
            var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + urlPrefix
            
            var url = NSURL (string: urlString)
        
        if url != nil {
                let task = NSURLSession.sharedSession().dataTaskWithURL(url!){ (data, response, error) in
                
                    var urlContent = NSString(data: data, encoding:NSUTF8StringEncoding) as String
                
                
                    var contentArray = NSMutableArray(array: urlContent.componentsSeparatedByString("<span class=\"phrase\">"))
                
                
                    var newContentArray = NSMutableArray(array: contentArray[1].componentsSeparatedByString("</span>"))
                
                    dispatch_async(dispatch_get_main_queue()){
                        self.Weather.text = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as NSString
                    
                    }
                
                }
            
                        task.resume()
        } else {
            self.Weather.text = "Please enter a valid city"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

