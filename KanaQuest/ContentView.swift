//
//  ContentView.swift
//  KanaQuest
//
//  Created by Hanna on 01/08/24.
//

import SwiftUI

struct ContentView: View {
    
    enum QuestionMode: CaseIterable {
        case kana, romaji
    }
    
    let allKana: [KanaCharacter] = Bundle.main.decode("kana.json")
    
    // MARK: - State
    @State private var currentKana = [KanaCharacter]()
    @State private var answers = [KanaCharacter]()
    @State private var maxPosition = 4
    @State private var currentPosition = 0
    @State private var isWrong = false
    @State private var wrongAnswer = Set<String>()
    @State private var questionMode = QuestionMode.kana
    @State private var streak = 0
    
    var body: some View {
        VStack {
            if currentKana.isEmpty {
                Picker("Question Mode", selection: $questionMode) {
                    ForEach(QuestionMode.allCases, id: \.self) {
                        Text(String(describing: $0).capitalized
                        )
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Button("Start") {
                    selectKana()
                    selectAnswers()
                }
            } else {
                Text(text(for: currentKana[currentPosition], isQuestion: true))
                    .font(.system(size: 120))
                    .scaleEffect(isWrong ? 1.5 : 1)
                    .foregroundStyle(isWrong ? .red : .primary)
                    .transition(.push(from: .trailing))
                    .id(currentPosition)
                
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
                Text("Streak \(streak)")
                    .contentTransition(.numericText())
                    .font(.title.monospacedDigit())
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
        if questionMode == .kana {
            if isQuestion {
                character.kana
            } else {
                character.romaji
            }
        } else {
            if isQuestion {
                character.romaji
            } else {
                character.kana
            }
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
                streak += 1
                
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
            streak = 0
            
            withAnimation {
                isWrong = false
            }
        }
    }
}

#Preview {
    ContentView()
}
