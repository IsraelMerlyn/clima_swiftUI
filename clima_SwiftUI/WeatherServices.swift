//
//  WeatherServices.swift
//  clima_SwiftUI
//
//  Created by IsraMerlyn on 29/01/24.
//

import Foundation
import CoreLocation

public final class WeatherServices: NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "a9cd82e159a843ca0b2006188932c2a8"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping ((Weather)-> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest (forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)else {return}
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard error == nil, let data = data else {return}
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                let weather = Weather(response: response)
                self.completionHandler?(weather)
            }
            
        }.resume()
    }
}

extension WeatherServices: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        guard let location = locations.first else {return}
        
        makeDataRequest(forCoordinates: location.coordinate)
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather:[APIWeather]
}

struct APIMain:Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys:String, CodingKey {
        case description
        case iconName = "main"
    }
    
}
