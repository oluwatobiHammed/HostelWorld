//
//  View+OnLoad.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

extension View {
    func onLoad(perform action: @escaping () -> Void) -> some View {
        modifier (OnLoad(action: action))
    }
}

struct OnLoad: ViewModifier {
    let action: () -> Void
    @State private var loaded = false
    func body (content: Content) -> some View {
        content.onAppear {
            if !loaded {
                loaded = true
                action()
             }
        
        }
    }
}
