//
//  WeatherApp.swift
//  Weather
//
//  Created by Sharma, Shubham on 31/07/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }

        ImmersiveSpace(id: "Rain") {
            RainView()
        }
    }
}
