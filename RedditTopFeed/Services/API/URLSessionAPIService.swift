//
//  URLSessionAPIService.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

final class URLSessionAPIService: APIServiceProtocol {
    
    private lazy var session: URLSession = {
        return URLSession(configuration: .default)
    }()
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func send<T>(_ request: T, then handler: @escaping (Result<T.Response, Error>) -> Void) where T: APIRequest {
        let endpointURL = self.endpoint(for: request)
        let method = request.method
        let parameters = request.parameters()
        let encoding = request.parameterEncoding
        
        guard let preparedRequest: URLRequest = prepareRequest(endpointURL, method: method, parameters: parameters, encoding: encoding) else {
            handler(.failure(APIError.invalidRequestData))
            return
        }
        
        session.dataTask(with: preparedRequest) { (data, response, error) in
            if let error = error {
                print(error) // debug
                handler(.failure(error))
                return
            }
            
            guard let data = data else {
                handler(.failure(APIError.emptyData))
                return
            }
            
            do {
                let data = try self.decoder.decode(T.Response.self, from: data)
                
                DispatchQueue.main.async {
                    handler(.success(data))
                }
            } catch {
                handler(.failure(error))
            }
        }.resume()
    }
    
}

// MARK: - Helpers

extension URLSessionAPIService {
    
    private func prepareRequest(_ url: URL,
                                method: HTTPMethod = .get,
                                parameters: Any? = nil,
                                encoding: ParameterEncoding = URLEncoding()) -> URLRequest? {
        var request: URLRequest?
        
        do {
            request = URLRequest(url: url)
            request?.httpMethod = method.rawValue
            var encodedURLRequest: URLRequest?
            
            if let urlEncoding = encoding as? URLEncoding,
               let parameters = parameters as? Parameters {
                encodedURLRequest = try urlEncoding.encode(request!, with: parameters)
            } else {
                assertionFailure("Encoding method with these parameters is incorrect")
                return nil
            }
            
            return encodedURLRequest
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
    
    private func endpoint<T>(for request: T) -> URL where T: APIRequest {
        guard let baseUrl = URL(string: request.path, relativeTo: GlobalConsts.API.apiEndpointUrl) else {
            fatalError("Bad resourceName: \(request.path)")
        }
        
        guard let components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            fatalError("Bad url components: \(request.path)")
        }
        
        guard let url = components.url else {
            fatalError("Problem with final endpoint url")
        }
        
        return url
    }
    
}
