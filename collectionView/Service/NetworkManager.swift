
import UIKit
import Alamofire

enum Link {
    case manyPhoto
    case post
    var url: URL {
        switch self {
        case .manyPhoto:
            URL(string: "https://jsonplaceholder.typicode.com/photos/")!
        case .post:
            URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func sendPost(to url: URL, width data: WelcomeElement, completion: @escaping(Result<WelcomeElement, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: WelcomeElementPost.self ) { dataResponse in
                switch dataResponse.result {
                case .success(let welcomPost):
                    let welcom = WelcomeElement(welcomPost: welcomPost)
                    completion(.success(welcom))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func loadImage(for url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let dataImage):
                    completion(.success(dataImage))
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetch(id: Int, completion: @escaping(Result<WelcomeElement, AFError>) -> Void) {
        guard let url = URL(string: Link.manyPhoto.url.absoluteString + "\(id)") else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let response):
                    guard let data = response as? [String: Any] else { return }
                    let welcom = WelcomeElement(fieldsData: data)
                    completion(.success(welcom))
                case .failure(let error):
                    print(error)
                }
            }
    }
}

