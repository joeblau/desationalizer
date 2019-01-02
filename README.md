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
