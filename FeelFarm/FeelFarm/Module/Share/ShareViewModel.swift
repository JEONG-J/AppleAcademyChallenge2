//
//  ShareViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation

@Observable
class ShareViewModel {
    var selectedSegment: FieldType = .domain
    var sharedData: [SharedEmotion] = [
        .init(id: "123", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .happy, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "1232", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .angry, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "1233", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .inspiration, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "12113", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .sad, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "1233", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .touched, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "11223", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .happy, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()),
        .init(id: "123412423", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .inspiration, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date())
    ]
}
