//
//  ContentView.swift
//  Weather
//
//  Created by Sharma, Shubham on 31/07/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import CoreLocation
import WeatherKit
import Foundation

struct ContentView: View {

    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var currentLocation: CLLocation?
    @State private var weather: Weather?
    @State private var weatherCondition: WeatherCondition = .sleet
    @State private var showImmersiveSpace = false
    @State private var showRainSpace = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    var weatherConditionData: String {
        return weather?.currentWeather.condition.rawValue ?? ""
    }

    var body: some View {
        VStack {
            if let weather {
                VStack {
                    Text("San Francisco")
                        .font(.largeTitle)
                    Text("\(weather.currentWeather.temperature.formatted())")
                }
//                weather.currentWeather.condition = .sleet
                HourlyForcastView(hourWeatherList: hourlyWeatherData)
                .onChange(of: hourlyWeatherData.first?.condition) { _, newVal in
                    print("weatherCondition changed: \(newVal?.description ?? "NA")")
                    Task {
                        guard let condition = newVal,
                              let space = getImmersiveSpaceId(forCondition: condition) else {
                            await dismissImmersiveSpace()
                            return
                        }
                        await openImmersiveSpace(id: space)
                    }
                }
                
                TenDayForcastView(dayWeatherList: weather.dailyForecast.forecast)
            }
        }
        .padding()
        .task(id: locationManager.currentLocation) {
            do {
               // if let location = locationManager.currentLocation {
                let location = CLLocation(latitude: 67.774929, longitude: -122.419418)
                self.weather =  try await weatherService.weather(for: location)
               // }
            } catch {
                print(error)
            }
        }
    }
    func getImmersiveSpaceId(forCondition weatherCondition: WeatherCondition) -> String? {
        var space: String?
        switch weatherCondition {
        case .cloudy:
            space = "Rain"
        case .mostlyClear:
            space = "ImmersiveSpace"
        @unknown default: break
        }
        return space
    }
}


class LocationManager: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last, currentLocation == nil else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }
}

extension Date {
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
