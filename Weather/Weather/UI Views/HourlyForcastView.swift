//
//  HourlyForcastView.swift
//  Weather
//
//  Created by Sharma, Shubham on 31/07/23.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct HourlyForcastView: View {
    
    let hourWeatherList: [HourWeather]
    @State private var currentLocation: CLLocation?
    @State private var showImmersiveSpace = false
    @State private var showRainSpace = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("HOURLY FORECAST")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
//                        self.weatherCondition = hourWeatherItem.condition
                        VStack(spacing: 20) {
                            Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .foregroundColor(.yellow)
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.medium)
                            Text(hourWeatherItem.condition.rawValue)
                        }.padding()
                    }
                }
            }
        }
        
        .padding().background {
            Color.blue
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .foregroundColor(.white)
            
    }
}
