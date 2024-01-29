//
//  ContentView.swift
//  clima_SwiftUI
//
//  Created by IsraMerlyn on 29/01/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    
    var body: some View {
        VStack {
            Text(viewModel.cityName).font(.largeTitle).padding()
            
            Text(viewModel.temperature).font(.system(size: 70)).padding().bold()
            
            Text(viewModel.weatherIcon).font(.largeTitle).padding()
            
            Text(viewModel.weatherDescription  )
            
            
        }.onAppear(perform: {
            viewModel.refresh()
        })
           
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherServices()))
}

