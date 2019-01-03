import Foundation
import CreateML
import PipelineProcessor
import Swiftline

let trainGroup = DispatchGroup()
let pipelineProcessor = PipelineProcessor()

trainGroup.enter()
pipelineProcessor.loadTrainingData { data in
    guard let data = data else { return }
    let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
    do {
        let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
                                                       textColumn: "text",
                                                       labelColumn: "label")
        let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
        let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
        
        print("Training Accuracy:   ".s.Bold.f.Cyan + "\(trainingAccuracy)")
        print("Validatoin Accuracy: ".s.Bold.f.Cyan + "\(validationAccuracy)")
        
        let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
        let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
        
        print("Evaluation Accuracy: ".s.Bold.f.Cyan + "\(evaluationAccuracy)")
        
        if sentimentClassifier.validationMetrics.classificationError == -1.0 || evaluationMetrics.classificationError == -1.0 {
            
            print("No model created. More training data required ".s.Bold.f.Red)
            trainGroup.leave()
            return
        }
    
        pipelineProcessor.saveModel(classifier: sentimentClassifier)
        
    } catch {
        print(error)
    }
    trainGroup.leave()
}

trainGroup.wait()
