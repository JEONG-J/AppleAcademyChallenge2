//
//  HolidayService.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

class HolidayUsecase: HolidayUseCaseProtocl {
    private let holidayService: HolidayServiceProtocl
    
    init(holidayService: HolidayServiceProtocl = HolidayService()) {
        self.holidayService = holidayService
    }
    
    func executeGetHoliday(year: Int) -> AnyPublisher<HolidayResponse, MoyaError> {
        return holidayService.getHolidayData(year: year)
    }
}
