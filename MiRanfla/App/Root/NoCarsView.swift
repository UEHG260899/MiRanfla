//
//  NoCarsView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 29/08/24.
//

import SwiftUI

struct NoCarsView: View {
    
    @State var presentCarForm = false
    
    var body: some View {
        VStack {
            Button {
                presentCarForm = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundStyle(.customPrimary)
                    .frame(width: 80, height: 80)
            }
            
            Text("Aún no tienes ningún auto agregado")
                .multilineTextAlignment(.center)
                .font(.bold, size: .title)
            
            Text("Haz click en el símbolo de + para agregar uno.")
                .font(.regular, size: .body)
        }
        .sheet(isPresented: $presentCarForm) {
            AddCarView()
        }
    }
}

#if DEBUG
#Preview("Normal") {
    NoCarsView()
}


#Preview("With BG Color") {
    ZStack {
        Color.customBackground
            .ignoresSafeArea()
        
        NoCarsView()
    }
}

#endif
