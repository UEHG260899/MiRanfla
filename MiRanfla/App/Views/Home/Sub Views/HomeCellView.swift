//
//  HomeCellView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 04/09/24.
//

import SwiftUI

struct HomeCellView: View {

    let carMake: String
    let carModel: String
    let size: CGFloat

    // swiftlint:disable:next line_length
    private let gradient: RadialGradient = RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]),
                                                          center: .top,
                                                          startRadius: 50,
                                                          endRadius: 100)

    var body: some View {
        VStack(alignment: .leading) {
            Text(carMake)
                .font(.semibold, size: .body)

            Text(carModel)
                .font(.regular, size: .description)
        }
        .foregroundStyle(.text)
        .padding([.leading, .bottom])
        .frame(width: abs(size), height: abs(size), alignment: .bottomLeading)
        .background(gradient, in: RoundedRectangle(cornerRadius: 8))
    }
}

#if DEBUG
#Preview("Normal") {
    HomeCellView(carMake: "Toyota",
                 carModel: "Corolla",
                 size: UIScreen.main.bounds.width / 2)
}
#endif
