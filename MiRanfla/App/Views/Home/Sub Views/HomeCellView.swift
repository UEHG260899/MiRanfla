//
//  HomeCellView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 04/09/24.
//

import SwiftUI

struct HomeCellView: View {
    
    let size: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Toyota")
                .font(.semibold, size: .body)
            
            Text("Corolla")
                .font(.regular, size: .description)
        }
        .foregroundStyle(.text)
        .padding([.leading, .bottom])
        .frame(width: abs(size), height: abs(size), alignment: .bottomLeading)
        .background(RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]), center: .top, startRadius: 50, endRadius: 100), in: RoundedRectangle(cornerRadius: 8))
    }
}

#if DEBUG
#Preview("Normal") {
    HomeCellView(size: UIScreen.main.bounds.width / 2)
}
#endif
