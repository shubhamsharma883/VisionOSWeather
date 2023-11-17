//
//  TenDayForcastView.swift
//  Weather
//
//  Created by Sharma, Shubham on 31/07/23.
//

import SwiftUI
import WeatherKit

struct TenDayForcastView: View {
    
    let dayWeatherList: [DayWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10-DAY FORCAST")
                .font(.caption)
                .opacity(0.5)
            
            List(dayWeatherList, id: \.date) { dailyWeather in
                HStack {
                    Text(dailyWeather.date.formatAsAbbreviatedDay())
                        .frame(maxWidth: 50, alignment: .leading)
                    
                    Image(systemName: "\(dailyWeather.symbolName)")
                        .foregroundColor(.yellow)
                    
                    Text(dailyWeather.lowTemperature.formatted())
                        .frame(maxWidth: .infinity)
                    
                    Text(dailyWeather.highTemperature.formatted())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
//                .listRowBackground(Color.blue)
            }.listStyle(.plain)
        }
        .frame(height: 300).padding()
//        .background(content: {
//            Color.blue
//        })
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .foregroundColor(.white)
    }
    
}
