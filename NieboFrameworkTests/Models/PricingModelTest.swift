import XCTest
import RxTest
import RxBlocking
@testable import NieboFramework

class PricingModelTest: XCTestCase {
    
    var sut: PricingModel!
    
    override func setUp() {
        self.sut = PricingModel(mocked: true)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModel() {
        let result = try? self.sut.rx.initSession
            .toBlocking()
            .last()
        
        XCTAssertEqual(result, true)
    }

}
