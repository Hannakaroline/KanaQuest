//
//  ContentView.swift
//  KanaQuest
//
//  Created by Hanna on 01/08/24.
//

import SwiftUI

struct ContentView: View {
    let allKana: [KanaCharacter] = Bundle.main.decode("kana.json")
    
    @State private var currentKana = [KanaCharacter]()
    @State private var answers = [KanaCharacter]()
    @State private var maxPosition = 4
    @State private var currentPosition = 0
    
    var body: some View {
        VStack {
            if currentKana.isEmpty {
                Button("Start") {
                    selectKana()
                    selectAnswers()
                }
            } else {
                Text("Kana").font(.system(size: 120))
                
                Grid {
                    GridRow {
                        Button("A", action: {})
                        Button("B", action: {})
                    }
                    GridRow {
                        Button("C", action: {})
                        Button("D", action: {})
                    }
                }
            }
        }
        .padding()
    }
    
    func selectKana() {
        currentKana = allKana.prefix(maxPosition).shuffled()
    }
    
    func selectAnswers() {
        var allAnswers = Set(currentKana)
        allAnswers.remove(currentKana[currentPosition])
        
        answers = Array(allAnswers.shuffled().prefix(3))
        answers.append(currentKana[currentPosition])
        answers.shuffle()
    }
}

#Preview {
    ContentView()
}
