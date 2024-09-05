//
//  HomeCellView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 04/09/24.
//

import SwiftUI

struct HomeCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Toyota")
                .font(.semibold, size: .body)
            
            Text("Corolla")
                .font(.regular, size: .description)
        }
        .padding([.leading, .bottom])
        // TODO: Change TO use GeometryReader sizes
        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2, alignment: .bottomLeading)
        .background(RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]), center: .topTrailing, startRadius: 50, endRadius: 100), in: RoundedRectangle(cornerRadius: 8))
    }
}

#if DEBUG
#Preview("Normal") {
    HomeCellView()
}
#endif
