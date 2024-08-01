//
//  AnswerButton.swift
//  KanaQuest
//
//  Created by Hanna on 01/08/24.
//

import SwiftUI

struct AnswerButton: View {
    var text: String
    var submit: (String) -> Void
    
    var body: some View {
        Button {
            submit(text)
        } label: {
            Text(text)
                .frame(width: 100, height: 100)
                .font(.largeTitle)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AnswerButton(text: "x") { _ in
        
    }
}
