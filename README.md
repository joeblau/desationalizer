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
./blau -o project

# Build for debug
./blau -o build -c debug

# Build for release
./blau -o build -c release

# Run Teach - This requires manual intervention
./blau -o run -c release -t teach

# Run Train - This will run automatically
./blau -o run -c release -t train

# Run Predict - This will run automatically
./blau -o run -c release -t predict
```
