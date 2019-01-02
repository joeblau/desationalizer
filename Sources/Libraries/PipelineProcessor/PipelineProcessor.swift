import Foundation
import CoreML

public class PipelineProcessor {
    private let TRAINING_CSV = "/Pipeline/2-Taught/training.csv"
    private let fileManager = FileManager.default
    
    public init () {
        let path = fileManager.currentDirectoryPath.appending(TRAINING_CSV)
        if !fileManager.fileExists(atPath: path) {
            let data = "sentence,label\n".data(using: .utf8)
            fileManager.createFile(atPath: path,
                                   contents: data,
                                   attributes: nil)
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
}
