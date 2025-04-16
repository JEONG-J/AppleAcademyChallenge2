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

class HolidayService: HolidayServiceProtocl {
    private let provider: MoyaProvider<HolidayAPITarget>
    
    init(provider: MoyaProvider<HolidayAPITarget> = MoyaProvider<HolidayAPITarget>()) {
        self.provider = provider
    }

    func getHolidayData(year: Int) -> AnyPublisher<HolidayResponse, MoyaError> {
        return provider.requestPublisher(.getHoliday(year: year))
            .handleEvents(receiveOutput: { response in
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("Raw JSON Response: \n\(jsonString)")
                }
            })
            .map(\.data)
            .decode(type: HolidayResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? MoyaError ?? MoyaError.underlying(error, nil)
            }
            .eraseToAnyPublisher()
    }
}
