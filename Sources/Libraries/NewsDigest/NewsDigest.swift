import Foundation


public class NewsDigest {
    private let NEWS_API_KEY = "775e0b6edf854b6eae07b6c2c2d7cc41"
    private let COUNTRY_CODE = "us"
    private let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    private let decoder = JSONDecoder()
    
    public init() {}
    
    public func requesetTopheadlines(completion: @escaping (Articles) -> Void) {
        guard var URL = URL(string: "https://newsapi.org/v2/top-headlines") else { return }
        let URLParams = [
            "country": COUNTRY_CODE,
            "apiKey": NEWS_API_KEY,
            "category": "technology",
            "pageSize": "100",
            ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                error == nil else {
                    print("URL Session Task Failed: %@", error!.localizedDescription);
                    return
            }
            
            print("URL Session Task Succeeded: HTTP \(statusCode)")

            do {
                let articles = try self.decoder.decode(Articles.self, from: data)
                completion(articles)
            } catch {
                print(error)
            }

        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func requestSources(completion: @escaping (Sources) -> Void ) {
        guard var URL = URL(string: "https://newsapi.org/v2/sources") else {return}
        let URLParams = [
            "language": "en",
            "country": COUNTRY_CODE,
            "apiKey": NEWS_API_KEY,
            ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                error == nil else {
                    print("URL Session Task Failed: %@", error!.localizedDescription);
                    return
            }
            
            print("URL Session Task Succeeded: HTTP \(statusCode)")
            
            do {
                let sources = try self.decoder.decode(Sources.self, from: data)
                completion(sources)
            } catch {
                print(error)
            }
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
