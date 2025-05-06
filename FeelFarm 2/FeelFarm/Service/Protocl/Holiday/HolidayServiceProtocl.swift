//
//  HolidayServiceProtocl.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation
import Moya
import Combine

protocol HolidayServiceProtocl {
    func getHolidayData(year: Int) -> AnyPublisher<HolidayResponse, MoyaError>
}
