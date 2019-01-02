import Foundation
import Swiftline
import NewsDigest
import Splitter

if #available(OSX 10.13, *) {
    let newsDigest = NewsDigest()
    let splitter = Splitter()
    let teachGroup = DispatchGroup()

    teachGroup.enter()
    newsDigest.requesetTopHeadlines { headlines in
        headlines.articles?
            .compactMap { $0.content }                  // Get article content
            .compactMap{ splitter.split(article: $0) }  // Split content into sentences
            .flatMap { $0 }                             // Flatten articles sentences into one array of sentences
            .forEach { sentence in
                print(sentence.s.Bold.f.Magenta)
                let choice = choose("Tag the sentence (1/2/3/4): ".f.Yellow, choices: "Sensational", "Fluff", "News", "Ignore")
                choice.lowercased()
        }
        teachGroup.leave()
    }
    teachGroup.wait()
} else {
    print("This application only runs on macOS 10.13+")
}
