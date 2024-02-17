//
//  PullToRefresh.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct PullToRefresh: ViewModifier {
    @Binding var isRefreshing: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            if self.isRefreshing {
                content
                    .offset(y: -geometry.size.height)
                    .onAppear {
                        withAnimation {
                            self.action()
                        }
                        
                    }
            } else {
                content
            }
        }
    }
}

extension View {
    func pullToRefresh(isRefreshing: Binding<Bool>, action: @escaping () -> Void) -> some View {
        self.modifier(PullToRefresh(isRefreshing: isRefreshing, action: action))
    }
}

//#Preview {
//    PullToRefresh(isRefreshing: <#Binding<Bool>#>, action: <#() -> Void#>)
//}
