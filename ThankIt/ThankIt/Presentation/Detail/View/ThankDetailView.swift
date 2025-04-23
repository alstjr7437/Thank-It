//
//  ThankDetailView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI

struct ThankDetailView: View {
    
    @StateObject private var container: DetailContainer
    
    init(thank: Thank, userNickName: String) {
        _container = StateObject(wrappedValue: DetailContainer(thank: thank, userNickName: userNickName))
    }
    
    var state: DetailState { return container.state }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                PostItView(thank: state.thank, size: Metrics.detailPostItSize)
                
                if state.userNickName == state.thank.userNickName {
                    HStack(spacing: 20) {
                        NavigationLink {
                            ThankCreateView(thank: state.thank) {
                                // TODO: 완료하고 데이터 동기화 처리
                            }
                        } label: {
                            Text("수정하기")
                                .frame(width: Metrics.buttonWidthFrame, height: Metrics.buttonHeightFrame)
                                .foregroundStyle(.black)
                                .background(.point)
                                .cornerRadius(Metrics.buttonConerRadius)
                                .shadow(radius: 4, x: 4, y: 4)
                        }
                        
                        Button {
                            container.send(.deleteThank(state.thank))
                        } label: {
                            Text("삭제하기")
                                .frame(width: Metrics.buttonWidthFrame, height: Metrics.buttonHeightFrame)
                                .foregroundStyle(.white)
                                .background(.red)
                                .cornerRadius(Metrics.buttonConerRadius)
                                .shadow(radius: 4, x: 4, y: 4)
                        }
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

private extension ThankDetailView {
    enum Metrics {
        static let buttonWidthFrame = 125.0
        static let buttonHeightFrame = 45.0
        static let buttonConerRadius = 8.0
        static let detailPostItSize = 300.0
    }
}

#Preview {
    ThankDetailView(thank: DummyData.Thanks[0], userNickName: "Kinder")
}
