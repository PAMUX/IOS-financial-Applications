//
//  Analytics.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 24/09/2023.
//

import SwiftUI
import Foundation

extension Double {
    var degreesToRadians: Double {
        return self * .pi / 180
    }
}

struct PizzaSliceShape: Shape {
    var startAngle: Double
    var endAngle: Double
    var indentationAngle: Double // Angle
    var radius: CGFloat // Radius pie
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.degreesToRadians)),
            y: center.y + radius * CGFloat(sin(startAngle.degreesToRadians))
        )
        
        let indent = CGPoint(
            x: center.x + (radius - 15) * CGFloat(cos(indentationAngle.degreesToRadians)),
            y: center.y + (radius - 15) * CGFloat(sin(indentationAngle.degreesToRadians))
        )
        
        path.move(to: center)
        path.addLine(to: start)
        path.addLine(to: indent)
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: endAngle), clockwise: false)
        path.closeSubpath()
        
        return path
    }
}


struct PieChartView: View {
    var percentages: [Double]
    var colors: [Color]
    
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2.0
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            
            ZStack {
                ForEach(0..<percentages.count, id: \.self) { index in
                    let startAngle = index == 0 ? 0.0 : percentages[0..<index].reduce(0.0, +) * 3.6
                    let endAngle = percentages[0..<index + 1].reduce(0.0, +) * 3.6
                    let indentationAngle = (startAngle + endAngle) / 2.0
                    PizzaSliceShape(
                        startAngle: startAngle,
                        endAngle: endAngle,
                        indentationAngle: indentationAngle,
                        radius: radius
                    )
                    .fill(colors[index])
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut(duration: 1.0))
        }
    }
}

struct Analytics: View {
    var body: some View {
        let categories = ["Food", "Clothes", "Loans", "Bills", "Rent", "Other"]
        let percentages = [35, 15, 15, 5, 10, 20.0]
        let colors: [Color] = [.blue, .green, .red, .yellow, .orange, .purple]
        
        VStack {
            Text("Report of Expenses")
                          .font(.title)
                          .padding(.bottom, 10)
                      
            PieChartView(percentages: percentages, colors: colors)
                .frame(width: 250, height: 250)
                .padding(.bottom, 20)
            // Legend
            ForEach(0..<categories.count, id: \.self) { index in
                HStack {
                    Circle()
                        .fill(colors[index])
                        .frame(width: 10, height: 10)
                    Text("\(categories[index]): \(Int(percentages[index]))%")
                    
                }
            }
        }
    }
}

struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        Analytics()
    }
}
