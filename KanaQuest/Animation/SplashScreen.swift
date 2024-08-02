//
//  SplashScreen.swift
//  KanaQuest
//
//  Created by Hanna on 02/08/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            LottieView(name: "smiling_dog")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
        }
    }
}
