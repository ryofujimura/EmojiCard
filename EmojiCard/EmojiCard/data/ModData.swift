//
//  ViewModifier.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import Foundation
import UIKit
import SwiftUI

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var emojis: [Character] { filter { $0.isEmoji } }
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
}

extension Color {
    static let lightShadow = Color(red: 234 / 255, green: 239 / 255, blue: 246 / 255)
    static let darkShadow = Color(red: 183 / 255, green: 197 / 255, blue: 218 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct TextFieldDynamicWidth: View {
    let title: String
    @Binding var text: String
    @State private var textRect = CGRect()
    
    var body: some View {
        ZStack {
            Text(text == "" ? title : text).background(GlobalGeometryGetter(rect: $textRect)).layoutPriority(1).opacity(0)
            HStack {
                TextField(title, text: $text)
                    .frame(width: textRect.width)
                    .modifier(TextFieldModifier())
            }
        }
    }
}

struct GlobalGeometryGetter: View {
    @Binding var rect: CGRect
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .submitLabel(.send)
            .padding()
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct CardModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
//            .aspectRatio(2, contentMode: .fit)
            .frame(width: screen.width - 100)
            .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct EntireScreen : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .opacity(0.0)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct EmojiModifier : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .font(.system(size: 150.0))
//                .frame(width: 300)
                .position(x: .random(in: 0...proxy.size.width),
                          y: .random(in: 0...proxy.size.height))
                .blur(radius: 50)
        }
    }
}

//struct PullModifier : ViewModifier {
//    @State private var appearOpacity = 0.0
//    
//    func body(content: Content) -> some View {
//        content
//            .transition(AnyTransition.offset(x: 100, y: 0)
//                            .animation(.linear(duration: 5)))
//            .onAppear(perform: {
//                withAnimation(.easeIn(duration: 1.5)) {
//                    appearOpacity = 1.0
//                }
//            })
//    }
//}

struct Config {    
    static let leftWaveY = 650.0
    static let rightWaveY = 650.0
    static let buttonRadius = 10.0
    static let buttonMargin = 2.0
    static let arrowWidth = 4.0
    static let arrowHeight = 10.0
    static let swipeVelocity = 0.45
    static let swipeCancelThreshold = 0.15
    static let waveMinLedge = 10.0
    static let waveMinHR = 16.0
    static let waveMinVR = 35.0

    static let colors : [Color] = [Color(red: 62 / 255, green: 77 / 255, blue: 92 / 255), Color(red: 92 / 255, green: 62 / 255, blue: 81 / 255)]
    static let pageView : [Any] = [EmojiView(), CardView()]
            
}

enum SliderDirection {
    case left
    case right
}

struct SliderData {
    let side: SliderDirection
    let centerY: Double
    let progress: Double
    
    init(side: SliderDirection, centerY: Double, progress: Double) {
        self.side = side
        self.centerY = centerY
        self.progress = progress
    }
    
    init(side: SliderDirection) {
        self.init(side: side, centerY: side == .left ? Config.leftWaveY : Config.rightWaveY, progress: 0)
    }
    
    static var screenWidth: Double {
        return Double(UIScreen.main.bounds.width)
    }
    
    static var screenHeight: Double {
        return Double(UIScreen.main.bounds.height)
    }
    
    var waveLedgeX: Double {
        let ledge = Config.waveMinLedge.interpolate(to: SliderData.screenWidth, in: progress, min: 0.2, max: 0.8)
        return side == .left ? ledge : SliderData.screenWidth - ledge
    }
    
    var waveHorizontalRadius: Double {
        let p1: Double = 0.4
        let to = SliderData.screenWidth * 0.8
        if progress <= p1 {
            return Config.waveMinHR.interpolate(to: to, in: progress, max: p1)
        } else if progress >= 1 {
            return to
        }
        let t = (progress - p1) / (1 - p1)
        let m: Double = 9.8
        let beta: Double = 40.0 / (2 * m)
        let omega = pow(-pow(beta, 2) + pow(50.0 / m, 2), 0.5)
        return to * exp(-beta * t) * cos(omega * t)
    }
    
    var buttonOffset: CGSize {
        let sign = side == .left ? 1.0 : -1.0
        let hs = Config.buttonRadius + Config.buttonMargin
        return CGSize(width: waveLedgeX + sign * (waveHorizontalRadius - hs) , height: centerY)
    }
    
    var buttonOpacity: Double {
        return max( 1 - progress * 5.0, 0)
    }
    
    var waveVerticalRadius: Double {
        return Config.waveMinVR.interpolate(to: SliderData.screenHeight * 0.9, in: progress, max: 0.4)
    }
    
    func initial() -> SliderData {
        return SliderData(side: side, centerY: centerY, progress: 0)
    }
    
    func final() -> SliderData {
        return SliderData(side: side, centerY: centerY, progress: 1)
    }
    
    func drag(value: DragGesture.Value) -> SliderData {
        let dx = (side == .left ? 1 : -1) * Double(value.translation.width)
        let progress = min(1.0, max(0, dx * Config.swipeVelocity / SliderData.screenWidth))
        return SliderData(side: side, centerY: Double(value.location.y), progress: progress)
    }
    
    func isCancelled(value: DragGesture.Value) -> Bool {
        return drag(value: value).progress < Config.swipeCancelThreshold
    }
    
    
}

//extension Color {
//    init(netHex: Int) {
//        self.init(red: netHex.ff(16), green: netHex.ff(08), blue: netHex.ff(00))
//    }
//}

extension Int {
    func ff(_ shift: Int) -> Double {
        return Double((self >> shift) & 0xff) / 255
    }
}

extension Double {
    func interpolate(to: Double, in fraction: Double, min: Double = 0, max: Double = 1) -> Double {
        if fraction <= min {
            return self
        } else if fraction >= max {
            return to
        }
        
        return self + (to - self) * (fraction - min) / (max - min)
    }
}

struct WaveView: Shape {
    
    private let side: SliderDirection
    private var centerY: Double
    private var progress: Double
    
    
    init(data: SliderData) {
        self.side = data.side
        self.centerY = data.centerY
        self.progress = data.progress
    }
    
    internal var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(centerY, progress) }
        set {
            centerY = newValue.first
            progress = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let data  = SliderData(side: side, centerY: centerY, progress: progress)
        let waveLedge = data.waveLedgeX
        let hr = data.waveHorizontalRadius
        let vr = data.waveVerticalRadius
        let curveStartY = vr + data.centerY
        let isLeft = self.side == .left
        let sign = isLeft ? 1.0 : -1.0
        
        
        let x = isLeft ? -50.0 : SliderData.screenWidth + 50
        path.move(to: CGPoint(x: waveLedge, y: -100))
        path.addLine(to:  CGPoint(x: x, y: -100))
        path.addLine(to: CGPoint(x: x, y: SliderData.screenHeight))
        path.addLine(to: CGPoint(x: waveLedge, y: SliderData.screenHeight))
        path.addLine(to: CGPoint(x: waveLedge, y: curveStartY))
        
        
        
        var index = 0
        while index <  WaveView.data.count {
            let x1 = waveLedge + sign * hr * WaveView.data[index]
            let y1 = curveStartY - vr * WaveView.data[index + 1]
            let x2 = waveLedge + sign * hr * WaveView.data[index + 2]
            let y2 = curveStartY - vr * WaveView.data[index + 3]
            let x = waveLedge + sign * hr * WaveView.data[index + 4]
            let y = curveStartY - vr * WaveView.data[index + 5]
            index += 6
            
            path.addCurve(
                to: CGPoint(x: x, y: y),
                control1: CGPoint(x: x1, y: y1),
                control2: CGPoint(x: x2, y: y2)
            )
        }
        
        return path
  
    }
    private static let data = [       0, 0.13461, 0.05341, 0.24127, 0.15615, 0.33223,
                                0.23616, 0.40308, 0.33052, 0.45611, 0.50124, 0.53505,
                                0.51587, 0.54182, 0.56641, 0.56503, 0.57493, 0.56896,
                                0.72837, 0.63973, 0.80866, 0.68334, 0.87740, 0.73990,
                                0.96534, 0.81226,       1, 0.89361,       1,       1,
                                      1, 1.10014, 0.95957, 1.18879, 0.86084, 1.27048,
                                0.78521, 1.33305, 0.70338, 1.37958, 0.52911, 1.46651,
                                0.52418, 1.46896, 0.50573, 1.47816, 0.50153, 1.48026,
                                0.31874, 1.57142, 0.23320, 1.62041, 0.15411, 1.68740,
                                0.05099, 1.77475,       0, 1.87092,       0,       2]
    
}
