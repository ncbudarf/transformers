//
//  PieChartView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

public struct PieChartSliceView: View {
    var geometry: GeometryProxy
    var pieSlice: PieSlice
    @State private var show: Bool = false
    
    var path: Path {
        let chartSize = geometry.size.width / 2
        let radius = chartSize * (CGFloat(pieSlice.pieRecipe.value) / 10.0)//TODO: This 10.0 is a magic number
        let centerX = chartSize
        let centerY = chartSize
        
        var path = Path()
        path.move(to: CGPoint(x: centerX, y: centerY))
        path.addArc(center: CGPoint(x: centerX, y: centerY),
                    radius: radius,
                    startAngle: pieSlice.startAngle,
                    endAngle: pieSlice.endAngle,
                    clockwise: false)
        return path
    }
    
    public var body: some View {
        ZStack {
            path.fill(pieSlice.pieRecipe.color)
                .overlay(path.stroke(Color.white, lineWidth: 1))
                .scaleEffect(self.show ? 1 : 0)
                .animation(
                    Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)
                    .delay(Double(pieSlice.pieRecipe.value) * 0.05)
                ).onAppear() {
                        self.show = true
                }
        }
        
    }
}

