//
//  CarSpecsSectionView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct CarSpecsSectionView: View {
    
    @State private var test = ""
    @State private var plateState: States = .cdmx
    
    var body: some View {
        Section {
            TextField("Kilometraje", text: $test)
                .font(.regular, size: .body)
            
            TextField("Capacidad del tanque", text: $test)
                .font(.regular, size: .body)
            
            Picker(selection: $plateState) {
                ForEach(States.allCases, id: \.self) { state in
                    Text(state.rawValue)
                        .font(.regular, size: .body)
                }
            } label: {
                Text("Estado de emplacado")
                    .font(.regular, size: .body)
            }

        } header: {
            Text("Características adicionales")
                .textCase(.none)
                .font(.regular, size: .body)
        }
    }
}

#Preview {
    Form {
        CarSpecsSectionView()
    }
}
