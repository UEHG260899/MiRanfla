//
//  ContentView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "car")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.bold, size: .title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}