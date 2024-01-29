//
//  WeatherViewModel.swift
//  clima_SwiftUI
//
//  Created by IsraMerlyn on 29/01/24.
//

import Foundation


private let defaultIcon = "❓"
private let defaultNameCity = "Tlaxiaco"
private let iconMap = [
    "Drizzle" : "🌨️",
    "Thunderstorm": "🌨️",
    "Rain":"⛈️",
    "Snow":"❄️",
    "Clear":"☀️",
    "Clouds":"☁️",
]

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "ciudad"
    @Published var temperature: String = "___"
    @Published var weatherDescription: String = "___"
    @Published var weatherIcon: String = defaultIcon
    
    
    public let weatherService: WeatherServices
    
    init(weatherService: WeatherServices ){
        
        self.weatherService = weatherService
    }
    
    func refresh() {
        weatherService.loadWeatherData{ weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
    
}
