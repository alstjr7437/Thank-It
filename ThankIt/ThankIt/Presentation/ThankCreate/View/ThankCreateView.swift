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
            TextField("감사한 일을 적어주세요!", text: $content)
            createSelectView(title: "공개 여부", isOn: $isPublic)
            createSelectView(title: "익명 여부", isOn: $isAnonymous)
            DatePickerOptionView(title: "날짜 선택", selectedDate: $selectedDate)
            ColorPickerOptionView(title: "색상 선택", selectedColor: $selectedColor)
            Spacer()
            CreateButtonView {
                print("hello")
            }
        }
    }
}

extension ThankCreateView {
    struct createSelectView: View {
        let title: String
        @Binding var isOn: Bool
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
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
