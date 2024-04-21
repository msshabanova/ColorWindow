//
//  ContentView.swift
//  ColorWindow
//
//  Created by Мария Шабанова on 21.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            VStack(spacing: 40) {
                RoundedRectangle(cornerRadius: 25.0)
                    .customize(redValue: redSliderValue, greenValue: greenSliderValue, blueValue: blueSliderValue)
                VStack {
                    ColorSliderView(sliderValue: $redSliderValue, color: .red)
                    ColorSliderView(sliderValue: $greenSliderValue, color: .green)
                    ColorSliderView(sliderValue: $blueSliderValue, color: .blue)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted())
                .foregroundStyle(.white)
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .accentColor(color)
        }
    }
}

struct ColorModifier: ViewModifier {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    func body(content: Content) -> some View {
        content.frame(width: 350, height: 150)
            .foregroundStyle(Color(red: redValue/255, green: greenValue/255, blue: blueValue/255))
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(.white, lineWidth: 4))
    }
}

extension View {
    func customize(redValue: Double, greenValue: Double, blueValue: Double) -> some View {
        modifier(ColorModifier(redValue: redValue, greenValue: greenValue, blueValue: blueValue))
    }
}
