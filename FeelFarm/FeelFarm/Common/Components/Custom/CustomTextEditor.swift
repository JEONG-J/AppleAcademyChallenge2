//
//  TextEditor.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CustomTextEditor: ViewModifier {
    @Binding var isModify: Bool
    @Binding var text: String
    let placeholder: String
    let maxTextCount: Int
    let background: Color
    
    init(text: Binding<String>, placeholder: String, maxTextCount: Int, background: Color) {
        self._isModify = .constant(true)
        self._text = text
        self.placeholder = placeholder
        self.maxTextCount = maxTextCount
        self.background = background
    }
    
    init(isModify: Binding<Bool>, text: Binding<String>, background: Color) {
        self._isModify = isModify
        self._text = text
        self.placeholder = ""
        self.maxTextCount = 300
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 20)
            .padding(.horizontal, 18)
            .padding(.bottom, 40)
            .background(alignment: .topLeading, content: {
                if text.isEmpty {
                    Text(makeStyledText(for: placeholder))
                        .lineLimit(nil)
                        .lineSpacing(2.5)
                        .padding(.vertical, 22)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                        .font(.T16Regular)
                        .foregroundStyle(Color.gray04)
                }
            })
            .textInputAutocapitalization(.none)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.T16medium)
            .foregroundStyle(Color.black)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .overlay(alignment: .bottomTrailing, content: {
                if isModify {
                    HStack(spacing: 0, content: {
                        Text("\(text.count)")
                            .font(.T14medium)
                            .foregroundStyle(text.count == maxTextCount ? Color.negative : Color.positive)
                        
                        Text(" / \(maxTextCount)")
                            .font(.T14medium)
                            .foregroundStyle(Color.gray04)
                    })
                    .padding(.trailing, 15)
                    .padding(.bottom, 20)
                    .onChange(of: text, { _, newValue in
                        if newValue.count > maxTextCount {
                            text = String(newValue.prefix(maxTextCount))
                        }
                    })
                }
            })
    }
    
    func makeStyledText(for text: String, with font: Font = .T16bold) -> AttributedString {
        var attributedText = AttributedString(text)
        
        if let aiText = attributedText.range(of: "감자도리 AI") {
            attributedText[aiText].foregroundColor = Color.feelFarmOrange
            attributedText[aiText].font = font
        }
        
        return attributedText
    }
}

extension TextEditor {
    func createExperience(text: Binding<String>, placeholder: String, maxTextCount: Int, background: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, background: background))
    }
    
    func detailExperience(isModify: Binding<Bool>, text: Binding<String>, background: Color) -> some View {
        self.modifier(CustomTextEditor(isModify: isModify, text: text, background: background))
    }
}
