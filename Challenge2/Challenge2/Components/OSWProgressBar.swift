//
//  OSWProgressBar.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

struct OSWProgressBar: View {
    let totalSteps: Int
    @Binding var currentStep: Int
    
    var body: some View {
        HStack {
            ForEach(1...totalSteps, id: \.self) { index in
                HStack {
                    ZStack {
                        Circle()
                            .fill(index <= currentStep ? .main : .oswGray3)
                            .frame(width: 30, height: 30)
                            .scaleEffect(index == currentStep ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: currentStep)
                        
                        Text("\(index)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(index <= currentStep ? .osWblack : .oswGray1)
                            .animation(.easeInOut(duration: 0.3), value: currentStep)
                    }
                    
                    if index != totalSteps {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(index < currentStep ? .main : .oswGray3)
                            .frame(height: 5)
                            .animation(.easeInOut(duration: 0.5), value: currentStep)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    OSWProgressBar(totalSteps: 3, currentStep: .constant(1))
}
