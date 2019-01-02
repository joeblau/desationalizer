# Desationalizer

Monorepo for [Desational](https://github.com/desational)

## Contents

### Executables

1. **Teach** [Manual] - Teach a neural network how to identify sensationalized
2. **Train** [Automatic] - Train a neural network based on tags
3. **Predict** [Automatic] - Predict which parts of a news article are sensationalized

### Libraries

- **NewsDigest** - Download news articles from [News API](https://newsapi.org)
- **Splitter** - Splits articles into sentences
- **PipelineProcessor** - Read and write data to the processing pipeline

### Pipeline

The processing pipeline for teaching, training, predicting and creating desationalized articles

- **1-Staged/** - Sensationalized news articles
- **2-Taught/** - Sentences where are tagged by a human indicating whether they are `sensational`, `fluff`, or `news`
- **3-Trained/** - Machine learning model trained based on examples from the previous stage
- **4-Predicted/** - Desationlized articles

## Commands

```sh
# Update Xcode Project
swift package generate-xcodeproj --xcconfig-overrides Package.xcconfig

# Build for debug
swift build -Xswiftc -target -Xswiftc x86_64-apple-macosx10.14

# Build for release
swift build -c release -Xswiftc -target -Xswiftc x86_64-apple-macosx10.14

# Run Teach - This requires manual intervention
./.build/release/Teach

# Run Train - This will run automatically
./.build/release/Train

# Run Predict - This will run automatically
./.build/release/Predict
```
