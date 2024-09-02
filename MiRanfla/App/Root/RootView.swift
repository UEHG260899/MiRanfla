//
//  RootView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 29/08/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            NoCarsView()
        }
    }
}

#if DEBUG
#Preview {
    RootView()
}
#endif
