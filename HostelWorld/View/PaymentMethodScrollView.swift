//
//  PaymentMethodScrollView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct PaymentMethodScrollView: View {
    let paymentMethod: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                
                ForEach(paymentMethod.indices, id: \.self) { index in
                    HStack {
                        Image(PaymentMethods(rawValue: paymentMethod[index])?.rawValue ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .background(Color.clear)
                            .padding(.all, 0)
                        Text(PaymentMethods(rawValue: paymentMethod[index])?.rawValue ?? "")
                            .font(Font(kFont.EffraRegular.of(size: 12)))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                            .padding()
                            .padding(.leading, -5)
                        
                    }
                    .padding(.all, 0)
                    .padding(.leading, index == 0 ? 15 : 0)
                    
                }
            }
        }
        .padding(.all, 0)
        
    }
}

//#Preview {
//    PaymentMethodScrollView()
//}
