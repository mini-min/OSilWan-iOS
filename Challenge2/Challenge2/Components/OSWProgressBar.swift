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
                            .animation(.easeInOut, value: currentStep)
                        
                        Text("\(index)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(index <= currentStep ? .osWblack : .oswGray1)
                            .animation(.easeInOut(duration: 1), value: currentStep)
                    }
                    
                    if index != totalSteps {
                        Rectangle()
                            .fill(index < currentStep ? .main : .oswGray3)
                            .frame(height: 6)
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
