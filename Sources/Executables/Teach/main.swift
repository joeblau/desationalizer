import Foundation
import Swiftline
import NewsDigest
import Splitter

if #available(OSX 10.13, *) {
    
    let newsDigest = NewsDigest()
    let splitter = Splitter()
    let teachGroup = DispatchGroup()
    
    teachGroup.enter()
    newsDigest.requesetTopheadlines { articles in
        articles.articles?
            .compactMap { article -> String? in
                article.content
            }
            .compactMap{ content -> [String]? in
                splitter.split(article: content)
            }
            .flatMap { $0 }
            .forEach { sentence in
                print(sentence)
                let choice = choose("Tag the sentence (1/2/3): ", choices: "Sensational", "Fluff", "News")
                choice.lowercased()
        }
        teachGroup.leave()
    }
    teachGroup.wait()
} else {
    print("This application only runs on macOS 10.13+")
}
