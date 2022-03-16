//
//  ChartMarkerView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import SwiftUI

struct MarkerTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let padding: CGFloat = -1
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: padding))
            path.addLine(to: CGPoint(x: width, y: padding))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addCurve(
                to: CGPoint(x: width * 0.5, y: height),
                control1: CGPoint(x: width, y: 3.5),
                control2: CGPoint(x: width * 0.5, y: height)
            )
            path.addCurve(
                to: CGPoint(x: 0, y: 0),
                control1: CGPoint(x: width * 0.5, y: height),
                control2: CGPoint(x: 0, y: 3.5)
            )
            path.closeSubpath()
        }
    }
}

struct MarkerRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        return Path { path in
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addCurve(
                to: CGPoint(x: width, y: height / 2),
                control1: CGPoint(x: width, y: 0),
                control2: CGPoint(x: width, y: 0)
            )
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: height / 2))
            path.addCurve(
                to: CGPoint(x: width / 2, y: 0),
                control1: CGPoint(x: 0, y: 0),
                control2: CGPoint(x: 0, y: 0)
            )
            path.closeSubpath()
        }
    }
}

struct ChartMarkerView: View {
    
    var content: String
    var rotate: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text(content)
                    .rotationEffect(rotate ? Angle.degrees(180) : Angle.zero)
                    .foregroundColor(.white)
                    .font(.footnote)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(
                        Rectangle()
                            .fill(Color("AccentColor"))
                            .clipShape(MarkerRectangle())
                    )
                    
                Rectangle()
                    .fill(Color("AccentColor"))
                    .clipShape(MarkerTriangle())
            }
            .rotationEffect(rotate ? Angle.degrees(180) : Angle.zero)
            .allowsHitTesting(false)
            .position(x: geometry.size.width / 2, y: -geometry.size.height)
            .fixedSize()
        }
        .fixedSize()
        .transition(
            .scale.animation(
                .spring(
                    response: 0.3,
                    dampingFraction: 0.7
                )
            )
        )
    }
}


struct ChartMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        ChartMarkerView(content: "20")
            
    }
}
