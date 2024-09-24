//
//  FontModifier.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 28/08/24.
//

import SwiftUI

struct FontModifier: ViewModifier {

    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    let font: Fonts.Name
    let size: Fonts.Size

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size.rawValue)
        return content.font(.custom(font.rawValue, size: scaledSize))
    }
}

extension View {
    func font(_ font: Fonts.Name, size: Fonts.Size) -> some View {
        self.modifier(FontModifier(font: font, size: size))
    }
}
