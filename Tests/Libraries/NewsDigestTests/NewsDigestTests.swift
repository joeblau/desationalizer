import XCTest
import NewsDigest

@available(OSX 10.13, *)
final class NewsDigestTests: XCTestCase {
    
    func testRequestTopArticles_technology() {
        let newsDigest = NewsDigest()
        let expectArticles = expectation(description: "top headlines request")
        newsDigest.requesetTopheadlines { articles in
            XCTAssertTrue(articles.status == "ok")
            XCTAssertTrue((articles.totalResults ?? 0) > 0)
            expectArticles.fulfill()
        }
        wait(for: [expectArticles], timeout: 5)
    }
    
    func testRequestSources() {
        let newsDigest = NewsDigest()
        let expectSources = expectation(description: "sources request")
        newsDigest.requestSources { sources in
            XCTAssertTrue(sources.status == "ok")
            XCTAssertTrue((sources.sources?.count ?? 0) > 0)
            expectSources.fulfill()
        }
        wait(for: [expectSources], timeout: 5)
    }

    static var allTests = [
        ("testRequestTopArticles", testRequestTopArticles_technology),
    ]
}
