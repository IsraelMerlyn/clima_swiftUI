//
//  clima_SwiftUIApp.swift
//  clima_SwiftUI
//
//  Created by IsraMerlyn on 29/01/24.
//

import SwiftUI

@main
struct clima_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(weatherService: WeatherServices()))
        
        }
    }
}
