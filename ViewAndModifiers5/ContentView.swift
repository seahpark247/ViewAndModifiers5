//
//  ContentView.swift
//  ViewAndModifiers5
//
//  Created by Seah Park on 3/3/25.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(Capsule().fill(Color.blue))
            .foregroundColor(.white)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct Watermark: ViewModifier {
    var text:String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                        // content!
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var motto1 = Text("motto1")
    
    var body: some View {
        ZStack {
            Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.green.gradient)
            
            VStack {
                CapsuleText(text: "CapluleText")
                motto1.modifier(Title())
                motto1.titleStyle()
                
                Color.yellow
                    .frame(width: 200, height: 100)
                    .watermarked(with: "watermarkk")
                
                GridStack(rows: 4, columns: 4) { row, column in
                    Image(systemName: "\(row * 4 + column).circle")
                    Text("R\(row) C\(column)")
                }
                .font(.subheadline)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
