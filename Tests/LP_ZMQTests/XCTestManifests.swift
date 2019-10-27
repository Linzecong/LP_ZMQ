import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LP_ZMQTests.allTests),
    ]
}
#endif
