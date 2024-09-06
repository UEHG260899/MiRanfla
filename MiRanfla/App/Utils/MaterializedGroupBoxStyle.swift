//
//  MaterializedGroupBoxStyle.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 05/09/24.
//

import SwiftUI


struct MaterializedGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            configuration.label
                .font(.bold, size: .body)
                .padding(.leading)
                .padding(.top, 8)
            configuration.content
                .padding(.leading)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.customBackground.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
    }
}


extension GroupBoxStyle where Self == MaterializedGroupBoxStyle {
    static var materialized: MaterializedGroupBoxStyle { .init() }
}
