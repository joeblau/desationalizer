import Foundation
import CreateML

public class PipelineProcessor {
    private let TRAINING_CSV = "/Pipeline/2-Taught/training.csv"
    private let DESATION_MODEL = "/Pipeline/3-Trained/Desational.mlmodel"
    private let fileManager = FileManager.default
    
    public init () {
        let path = fileManager.currentDirectoryPath.appending(TRAINING_CSV)
        if fileManager.fileExists(atPath: path) { return }
        
        let data = "text,label\n".data(using: .utf8)
        fileManager.createFile(atPath: path,
                               contents: data,
                               attributes: nil)
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
        let modelPath = URL(fileURLWithPath: path)
        do {
            try classifier.write(to: modelPath, metadata: metadata)
        } catch {
            print(error)
        }
    }
}
