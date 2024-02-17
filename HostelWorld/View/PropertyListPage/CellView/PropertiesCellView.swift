//
//  PropertiesCellView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct PropertiesCellView: View {
    let property: CityProperty
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:  25)
                .stroke(Color.primary, lineWidth: 0.3) // Change color and lineWidth as needed
                .clipShape(RoundedRectangle(cornerRadius: 25)) // Apply corner radius using clipShape
                .background(Color(UIColor(hexString: "#39404a")).opacity(0.1))
            VStack(spacing: 10) {
                Spacer().frame(height: 0)
                VerticalImageView(images: Array(property.images))
                    .frame(width: UIScreen.main.bounds.width - 68, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15)) // Adjust the corner radius value as needed
                VStack {
                    HStack {
                        Text(property.name ?? "")
                            .font(Font(kFont.EffraMediumRegular.of(size: 15)))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                            .padding()
                        Spacer()
                    }
                    .padding(.horizontal, 0)
                    
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.yellow)
                            .padding()
                        let stringFormat = String(format: "%.1f",  Double(property.overallRating?.overall.value ?? 0) / 10)
                        Text(stringFormat)
                            .font(Font(kFont.EffraMediumRegular.of(size: 18)))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding(.leading, -10)
                        Spacer()
                    }
                    .padding(.top, -30)
                    
                    HStack {
                        let manipulatedString = (property.type ?? "").prefix(1).capitalized + (property.type ?? "").dropFirst().lowercased()
                        Text("\(manipulatedString)  -")
                            .font(Font(kFont.EffraLightRegular.of(size: 12)))
                            .foregroundStyle(Color.primary.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding()
                        Text("\(property.city?.name ?? "")")
                            .font(Font(kFont.EffraLightRegular.of(size: 12)))
                            .foregroundStyle(Color.primary.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding(.leading, -20)
                        Spacer()
                    }
                    .padding(.top, -35)
                  
                }
                .padding(.leading, 7)
                Spacer()
                
            }
            .padding(.horizontal, 0)
            
        }
        
        
    }
}

#Preview {
    PropertiesCellView(property: CityProperty())
}

