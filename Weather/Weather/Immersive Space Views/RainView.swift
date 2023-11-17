//
//  RainView.swift
//  Weather
//
//  Created by Sharma, Shubham on 31/07/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct RainView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Rain", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
