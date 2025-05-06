//
//  CreateDragView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/17/25.
//

import SwiftUI

struct CreateDragView: View {
    
    @EnvironmentObject var container: DIContainer
    @Binding var showAddExperience: Bool
    
    var body: some View {
        VStack(spacing: 20, content: {
            
            Capsule()
                .fill(Color.gray03)
                .frame(width: 49, height: 3)
            
            
            Text("경험 생성하기")
                .font(.T18bold)
                .foregroundStyle(Color.black)
            
            fieldList
            
            Spacer()
        })
        .safeAreaPadding(.horizontal, 16)
        .safeAreaPadding(.top, 21)
    }
    
    private var fieldList: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            ForEach(FieldType.allCases, id: \.self) { field in
                Button(action: {
                    container.navigationRouter.push(to: .createExperience(field: field))
                    showAddExperience = false
                }, label: {
                    HStack(spacing: 9, content: {
                        field.createIcon
                        
                        Text(field.createText)
                            .font(.T14medium)
                            .foregroundStyle(Color.gray07)
                        
                        Spacer()
                    })
                    .padding()
                    .overlay(alignment: .bottom, content: {
                        if field != .design {
                            Divider()
                                .foregroundStyle(Color.gray02)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                        }
                    })
                })
            }
        })
        .safeAreaPadding(.top, 5)
    }
}
