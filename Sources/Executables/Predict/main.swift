import Foundation
import NewsDigest
import Splitter
import PipelineProcessor

let predictGroup = DispatchGroup()
let newsDigest = NewsDigest()
let splitter = Splitter()
let pipelineProcessor = PipelineProcessor()

guard let desationalPredictor = pipelineProcessor.desationalPredictor else {
    print("No predictor model created: Teach, then train your model.")
    exit(0)
}

[PostCategory.technology,
 PostCategory.business].forEach { category in
    predictGroup.enter()
    newsDigest.requesetTopHeadlines(category: category) { headlines in
        headlines.articles?
            .filter{ article -> Bool in
                article.title != nil && article.content != nil && article.author != nil
            }
            .forEach { article in
                guard let title = article.title?.split(separator: "-", maxSplits: 1).first,
                    let content = article.content,
                    let author = article.author else { return }
                
                let desationalContent = splitter.split(article: content)
                    .filter { "news" == desationalPredictor.predictedLabel(for: $0) }
                    .joined(separator: " ")
                let percent = String(Int((1 - (Double(desationalContent.utf8.count) / Double(content.utf8.count))) * 100))
                let post = DesationalPost(source: article.source.name,
                                          date: article.publishedAt,
                                          title: String(title),
                                          author: author,
                                          content: desationalContent,
                                          url: article.url,
                                          percent: percent)
                pipelineProcessor.write(post: post, in: category)
        }
        predictGroup.leave()
    }
}

predictGroup.wait()
