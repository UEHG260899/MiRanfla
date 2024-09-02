//
//  CarDataSectionView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct CarDataSectionView: View {
    
    @State private var test = ""
    
    var body: some View {
        Section {
            TextField("Marca", text: $test)
                .font(.regular, size: .body)
            
            TextField("Modelo (ej. Corolla)", text: $test)
                .font(.regular, size: .body)
            
            TextField("Año", text: $test)
                .font(.regular, size: .body)
            
            TextField("Terminación de la placa", text: $test)
                .font(.regular, size: .body)
        } header: {
            Text("Datos del vehículo")
                .textCase(.none)
                .font(.regular, size: .body)
        }
    }
}

#Preview {
    Form {
        CarDataSectionView()
    }
}
