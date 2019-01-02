import Foundation
import CreateML
import NaturalLanguage

public struct DesationalPost {
    public init(source: String,
             date: String,
             title: String,
             content: String,
             url: String,
             percent: String) {
        self.source = source
        self.date = date
        self.title = title
        self.content = content
        self.url = url
        self.percent = percent
    }
    public let source: String
    public let date: String
    public let title: String
    public let content: String
    public let url: String
    public let percent: String
}

public class PipelineProcessor {
    private let TRAINING_CSV = "/Pipeline/2-Taught/training.csv"
    private let DESATION_MODEL = "/Pipeline/3-Trained/Desational.mlmodel"
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
        if fileManager.fileExists(atPath: modelPath) {
            let modelURL = URL(fileURLWithPath: modelPath)
            desationalPredictor = try? NLModel(contentsOf: modelURL)
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
    
    public func saveModel(classifier: MLTextClassifier, metadata: MLModelMetadata) {
        let path = fileManager.currentDirectoryPath.appending(DESATION_MODEL)
        let modelURL = URL(fileURLWithPath: path)
        do {
            try classifier.write(to: modelURL, metadata: metadata)
        } catch {
            print(error)
        }
    }
    
    public func writePost(post: DesationalPost) {
        // TODO: Write post based on date and slugify
    }
}
