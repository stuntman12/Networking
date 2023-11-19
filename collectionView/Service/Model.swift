import UIKit

//MARK: - Welcom

struct WelcomeElement: Codable {
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(title: String, url: String, thumbnailUrl: String) {
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    init(fieldsData: [String: Any]) {
        title = fieldsData["title"] as? String ?? "No title in Data"
        url = fieldsData["url"] as? String ?? "No url in Data"
        thumbnailUrl = fieldsData["thumbnailUrl"] as? String ?? "No url in Data"
    }
    
    init(welcomPost: WelcomeElementPost) {
        self.title = welcomPost.title
        self.url = welcomPost.url
        self.thumbnailUrl = welcomPost.thumbnailUrl
    }
}

struct WelcomeElementPost: Codable {
    let title: String
    let url: String
    let thumbnailUrl: String
}



