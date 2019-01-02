import Foundation
import Swiftline
import NewsDigest
import Splitter
import PipelineProcessor

let teachGroup = DispatchGroup()
let newsDigest = NewsDigest()
let splitter = Splitter()
let pipelineProcessor = PipelineProcessor()

teachGroup.enter()
newsDigest.requesetTopHeadlines { headlines in
    headlines.articles?
        .compactMap { $0.content }                  // Get article content
        .compactMap{ splitter.split(article: $0) }  // Split content into sentences
        .flatMap { $0 }                             // Flatten articles sentences into one array of sentences
        .forEach { sentence in
            print(sentence.s.Bold.f.Cyan)
            let choice = choose("Tag the sentence (1/2/3/4/5): ".f.Magenta, choices: "Sensational", "Fluff", "News", "Ignore", "Quit")
            switch choice {
            case "Sensational", "Fluff", "News": pipelineProcessor.teach(sentence: sentence, is: choice.lowercased())
            case "Quit": teachGroup.leave()
            default: break
            }
    }
    teachGroup.leave()
}
teachGroup.wait()
