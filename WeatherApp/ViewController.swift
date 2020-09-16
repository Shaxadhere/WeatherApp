//
//  ViewController.swift
//  WeatherApp
//
//  Created by Shehzad on 15/09/2020.
//  Copyright © 2020 Shehzad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city_name: UILabel!
    
    @IBOutlet weak var weather_icon: UIImageView!
    
    @IBOutlet weak var weather_desc: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var last_checked: UILabel!
    
    @IBOutlet weak var feels_like: UILabel!
    
    @IBOutlet weak var wind_dir: UILabel!
    
    @IBOutlet weak var wind_speed: UILabel!
    
    @IBOutlet weak var refresh: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        
        
    }
    func getWeather(){
//        let urlString = "https://api.weatherstack.com/current?access_key=be6ae38cfd9b67a4f60a7ab12faf3754&query=Karachi"
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: "http://api.weatherstack.com/current?access_key=be6ae38cfd9b67a4f60a7ab12faf3754&query=Karachi")!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let data = data {
              
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
                    {
                        
                        let location = jsonArray["location"] as! Dictionary<String, Any>
                        let name = location["name"] as! String
                        
                        let currentData = jsonArray["current"] as! Dictionary<String,Any>
                        let temperature = currentData["temperature"] as! Int
                        let observation_time = currentData["observation_time"] as! String
                        let weatherIconArray = currentData["weather_icons"] as! [String]
                        let weatherIcon = weatherIconArray[0] as! String
                        let weather_descArray = currentData["weather_descriptions"] as! [String]
                        let weather_desc = weather_descArray[0] as! String
                        let wind_speed = currentData["wind_speed"] as! Int
                        let wind_dir = currentData["wind_dir"] as! String
                        let feelslike = currentData["feelslike"] as! Int
                        
                        self.city_name.text = name
                        self.feels_like.text = "Feels Like: " + String(feelslike)
                        self.last_checked.text = "Last Observed at: " + observation_time
                        self.temperature.text = String(temperature)
                        self.wind_speed.text = "Wind Speed: " + String(wind_speed) + " mph"
                        self.wind_dir.text = "Wind Direction: " + String(wind_dir)
                        self.weather_desc.text = weather_desc
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                
              }
            
            
        })
        task.resume()
    }

}

