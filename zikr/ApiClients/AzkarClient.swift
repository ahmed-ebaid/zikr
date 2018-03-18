import Moya
import SwiftyJSON

protocol AzkarClientProtocol {
    func getAzkarTimes(latitude: Double, longitude: Double, method: Int, month: Int, year: Int, completion: @escaping ClientCompletionClosure)
}

class AzkarClient : AzkarClientProtocol {
    func getAzkarTimes(latitude: Double,
                       longitude: Double,
                       method: Int,
                       month: Int,
                       year: Int,
                       completion: @escaping ClientCompletionClosure) {
        MoyaProvider<Endpoint>().request(.getAzkarTimes(latitude: latitude,
                                                        longitude: longitude,
                                                        method: method,
                                                        month: month,
                                                        year: year)) { result in
                                                            switch result {
                                                            case let .success(response):
                                                                do {
                                                                    let azkarTimes = try AzkarTime.arrayFromJSON(JSON(response.data))
                                                                        completion(nil, azkarTimes)
                                                                } catch(let error) {
                                                                    completion(error, nil)
                                                                }
                                                            case let .failure(error):
                                                                completion(error, nil)
                                                            }
                                                            
        }
    }
}
