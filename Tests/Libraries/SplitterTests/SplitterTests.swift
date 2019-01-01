import XCTest
import Splitter
//import class Foundation.Bundle


@available(OSX 10.13, *)
final class splitterTests: XCTestCase {
    func testSplitArticle() throws {
        let fourSentences = "I want to split a paragraph into sentences. But, there is a problem. My paragraph includes dates like Jan.13, 2014 , words like U.A.E and numbers like 2.2. I also have to factor in separating things like domain names because https://www.deslation.com has periods in it as well.  Also, What happens when I ask a question?  Then I being to exlaim! Please help me split this."
        let splitter = Splitter()
        let result = splitter.split(article: fourSentences)

        XCTAssertEqual(7, result.count)
        XCTAssertEqual("I want to split a paragraph into sentences.", result[0])
        XCTAssertEqual("But, there is a problem.", result[1])
        XCTAssertEqual("My paragraph includes dates like Jan.13, 2014 , words like U.A.E and numbers like 2.2.", result[2])
        XCTAssertEqual("I also have to factor in separating things like domain names because https://www.deslation.com has periods in it as well.", result[3])
        XCTAssertEqual("Also, What happens when I ask a question?", result[4])
        XCTAssertEqual("Then I being to exlaim!", result[5])
        XCTAssertEqual("Please help me split this.", result[6])
    }

    static var allTests = [
        ("testSplitArticle", testSplitArticle),
    ]
}
