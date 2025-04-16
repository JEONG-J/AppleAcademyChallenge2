//
//  HolidayServiceProtocl.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation
import Combine
import Moya

protocol HolidayUseCaseProtocl {
    func executeGetHoliday(year: Int) -> AnyPublisher<HolidayResponse, MoyaError>
}
