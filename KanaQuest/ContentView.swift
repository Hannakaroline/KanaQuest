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
    @State private var isWrong = false
    @State private var wrongAnswer = Set<String>()
    
    
    var body: some View {
        VStack {
            if currentKana.isEmpty {
                Button("Start") {
                    selectKana()
                    selectAnswers()
                }
            } else {
                Text(text(for: currentKana[currentPosition], isQuestion: true))
                    .font(.system(size: 120))
                    .scaleEffect(isWrong ? 1.5 : 1)
                    .foregroundStyle(isWrong ? .red : .primary)
                
                Grid {
                    GridRow {
                        button(index: 0)
                        button(index: 1)
                    }

                    GridRow {
                        button(index: 2)
                        button(index: 3)
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
    
    func text(for character: KanaCharacter, isQuestion: Bool = false) -> String {
        if isQuestion {
            character.kana
        } else {
            character.romaji
        }
    }
    
    func button(index: Int) -> some View {
        let text = text(for: answers[index])

        return AnswerButton(
            text: text, isWrong: wrongAnswer.contains(text),
            submit: checkAnswer
        )
    }
    
    func checkAnswer(_ answer: String) {
        if answer == text(for: currentKana[currentPosition]) {
            withAnimation {
                currentPosition += 1
                wrongAnswer.removeAll()

                if currentPosition >= maxPosition {
                    currentPosition = 0
                    maxPosition += 1

                    selectKana()
                }

                selectAnswers()
            }
        } else {
            isWrong = true
            wrongAnswer.insert(answer)
            
            withAnimation {
                isWrong = false
            }
        }
    }
}

#Preview {
    ContentView()
}
