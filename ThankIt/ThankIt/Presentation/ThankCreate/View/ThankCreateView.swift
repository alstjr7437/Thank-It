//
//  ThankCreateView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI

struct ThankCreateView: View {
    @State private var content: String = ""
    @State private var isPublic: Bool = false
    @State private var isAnonymous: Bool = false
    @State private var selectedDate: Date = Date()
    @State private var selectedColor: Color = .main
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ZStack(alignment: .topLeading) {
                        PostItBackgroundView(postIt: .square(color: .yellow))
                            .shadow(radius: 4, x: 1, y: 4)

                        TextEditor(text: $content)
                            .padding(20)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .font(.basicFont)
                    }
                    .frame(width: 350, height: 350)
                    .padding(.bottom, 20)

                    CreateSelectView(title: "공개 여부", isOn: $isPublic)
                    CreateSelectView(title: "익명 여부", isOn: $isAnonymous)
                    DatePickerOptionView(title: "날짜 선택", selectedDate: $selectedDate)
                    ColorPickerOptionView(title: "색상 선택", selectedColor: $selectedColor)
                }
                .padding()
            }
            Spacer()
            CreateButtonView {
                print("hello")
            }
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

extension ThankCreateView {
    struct CreateSelectView: View {
        let title: String
        @Binding var isOn: Bool
        var body: some View {
            HStack {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .onChange(of: isOn) {
                        UIApplication.shared.endEditing()
                    }
            }
            .padding(.horizontal)
        }
    }
    
    struct DatePickerOptionView: View {
        let title: String
        @Binding var selectedDate: Date

        var body: some View {
            HStack {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .foregroundColor(.main)
            }
            .padding(.horizontal)
        }
    }
    
    struct ColorPickerOptionView: View {
        let title: String
        @Binding var selectedColor: Color
        let colors: [Color] = [.main, .postColor1, .postColor2, .postColor3]

        var body: some View {
            HStack() {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: selectedColor == color ? 2 : 0)
                            )
                            .onTapGesture {
                                selectedColor = color
                                UIApplication.shared.endEditing()
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ThankCreateView()
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
