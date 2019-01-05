import Foundation
import CreateML
import NaturalLanguage
import Slugify
import NewsDigest

public class PipelineProcessor {
    private let TRAINING_CSV = "/Pipeline/2-Taught/training.csv"
    private let DESATION_MODEL = "/Pipeline/3-Trained/Desational.mlmodel"
    private let PREDICTED_PATH = "/Pipeline/4-Predicted/"
    private let fileManager = FileManager.default
    public var desationalPredictor: NLModel?
    
    public init () {
        let trainingPath = fileManager.currentDirectoryPath.appending(TRAINING_CSV)
        if !fileManager.fileExists(atPath: trainingPath) {
            let data = "text,label\n".data(using: .utf8)
            fileManager.createFile(atPath: trainingPath,
                                   contents: data,
                                   attributes: nil)
        }
        
        let modelPath = fileManager.currentDirectoryPath.appending(DESATION_MODEL)
        print(modelPath)
        if fileManager.fileExists(atPath: modelPath) {
            let modelURL = URL(fileURLWithPath: modelPath)
            do {
                let compiledModelURL = try MLModel.compileModel(at: modelURL)
                desationalPredictor = try NLModel(contentsOf: compiledModelURL)
            } catch {
                print(error)
            }
        }
    }
    
    public func teach(sentence: String, is label: String) {
        let path = fileManager.currentDirectoryPath.appending(TRAINING_CSV)

        guard let file = FileHandle(forUpdatingAtPath: path),
            let data = "\"\(sentence)\",\"\(label)\"\n".data(using: .utf8),
            fileManager.fileExists(atPath: path) else {
            print("Failed to open file")
            return
        }

        file.seekToEndOfFile()
        file.write(data)
        file.closeFile()
    }
    
    public func loadTrainingData(completion: (MLDataTable?) -> Void ) {
        let path = fileManager.currentDirectoryPath.appending(TRAINING_CSV)
        if !fileManager.fileExists(atPath: path) {
            completion(nil)
            return
        }
        
        let trainingPath = URL(fileURLWithPath: path)
        do {
            let trainingTable = try MLDataTable(contentsOf: trainingPath)
            completion(trainingTable)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    public func saveModel(classifier: MLTextClassifier) {
        let path = fileManager.currentDirectoryPath.appending(DESATION_MODEL)
        let modelURL = URL(fileURLWithPath: path)
        do {
            let metadata = MLModelMetadata(author: "Desational",
                                           shortDescription: "A model trained to classify sensational sentences",
                                           version: "1.0")
            try classifier.write(to: modelURL, metadata: metadata)
        } catch {
            print(error)
        }
    }
    
    public func write(post: DesationalPost, in category: PostCategory) {
        guard let postDate = post.date.toDate() else { return }
        
        let postSlug = String(post.title
            .trimmingCharacters(in: NSCharacterSet.whitespaces)
            .unicodeScalars
            .filter(NSCharacterSet.alphanumerics.union(.whitespaces).contains))
            .slugify()
        let markdownPost = """
        ---
        title: \(post.title)
        date: \(post.date)
        author: \(post.author)
        publication: \(post.source)
        originalURL: \(post.url)
        sensationalizedPercent: \(post.percent)
        ---
        
        \(post.content)
        """

        let postYearMonthDate = "/\(category.rawValue)/\(postDate.year)/\(postDate.month)/\(postDate.day)"
        let postDirectory = fileManager.currentDirectoryPath.appending(PREDICTED_PATH).appending(postYearMonthDate)
        
        if !fileManager.fileExists(atPath: postDirectory) {
            do {
                try fileManager.createDirectory(atPath: postDirectory,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
            } catch {
                print(error)
            }
        }
        
        let postPath = postDirectory.appending("/\(postSlug)")
        if !fileManager.fileExists(atPath: postPath) {
            let data = markdownPost.data(using: .utf8)
            fileManager.createFile(atPath: postPath,
                                   contents: data,
                                   attributes: nil)
        }
    }
}
