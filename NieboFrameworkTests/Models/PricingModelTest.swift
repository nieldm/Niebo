import XCTest
import RxTest
import RxBlocking
@testable import NieboFramework

class PricingModelTest: XCTestCase {
    
    var sut: PricingModel!
    
    override func setUp() {
        self.sut = PricingModel(mocked: true)
    }
    
    func testModel() {
        let result = try! self.sut.rx.initSession
            .toBlocking()
            .last()
        
        XCTAssertEqual(result?.status, Status.pending)
        XCTAssertEqual(result?.itineraries.count, 10)
        XCTAssertEqual(result?.itineraries.first?.pricingOptions.count, 5)
        XCTAssertEqual(result?.legs.count, 141)
    }
    
    func testQueryCompose() {
        let result = try! self.sut.rx.initSession
            .toBlocking()
            .last()
        
        guard let query = result?.compose() else {
            fatalError()
        }
        query.itineraries.forEach {
            XCTAssertNotNil($0.leg)
            XCTAssertGreaterThan($0.leg?.segments.count ?? 0, 0)
        }
    }

}
