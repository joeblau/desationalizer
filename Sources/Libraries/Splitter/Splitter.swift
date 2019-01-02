import Foundation

public class Splitter {
    private let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)

    public init() {}
    
    public func split(article: String) -> [String] {
        tagger.string = article
        
        var sentences = [String]()
        var offset = 0
        
        tagger.enumerateTags(in: NSRange(location:0, length: article.utf16.count),
                             unit: .word,
                             scheme: .nameType,
                             options: []) { tag, tokenRange, stop in
                                
                                guard let tag = tag, tag == NSLinguisticTag.sentenceTerminator else { return }
                                let start = article.index(article.startIndex, offsetBy: offset)
                                let end = article.index(article.startIndex, offsetBy: tokenRange.location)
                                sentences.append(String(article[start...end]).trimmingCharacters(in: .whitespaces))
                                
                                offset = tokenRange.location + 1
        }
        return sentences
    }
}
