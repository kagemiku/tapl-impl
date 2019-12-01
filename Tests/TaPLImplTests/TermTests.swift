//
//  TermTests.swift
//  TaPLImplTests
//
//  Created by kagemiku on 2019/11/30.
//

import XCTest
@testable import TaPLImpl

final class TermTests: XCTestCase {

    private let fi = FileInformation()

    func testIsVal() {
        let vTrue = Term.true(fi)
        XCTAssertTrue(vTrue.isVal)

        let vFalse = Term.false(fi)
        XCTAssertTrue(vFalse.isVal)

        let vZero = Term.zero(fi)
        XCTAssertTrue(vZero.isVal)

        let vSucc = Term.succ(fi, vZero)
        XCTAssertTrue(vSucc.isVal)
    }

    func testIsNumericVal() {
        let vZero = Term.zero(fi)
        XCTAssertTrue(vZero.isNumericVal)

        let vSucc = Term.succ(fi, vZero)
        XCTAssertTrue(vSucc.isNumericVal)

        let vSuccSucc = Term.succ(fi, vSucc)
        XCTAssertTrue(vSuccSucc.isNumericVal)
    }


}
