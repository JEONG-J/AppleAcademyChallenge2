//
//  HolidyResponse.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

struct HolidayResponse: Codable {
    let response: HolidayResponseBody
}

struct HolidayResponseBody: Codable {
    let header: HolidayHeader
    let body: HolidayBody
}

struct HolidayHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct HolidayBody: Codable {
    let items: HolidayItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct HolidayItems: Codable {
    let item: [Holiday]
}

struct Holiday: Codable {
    let dateKind: String
    let dateName: String
    let isHoliday: String
    let locdate: Int
    let seq: Int
}
