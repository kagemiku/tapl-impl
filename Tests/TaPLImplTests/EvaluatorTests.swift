//
//  EvaluatorTests.swift
//  TaPLImplTests
//
//  Created by kagemiku on 2019/12/01.
//

import XCTest
@testable import TaPLImpl

class EvaluatorTests: XCTestCase {

    private let fi = FileInformation()

    func testEval() {
        XCTContext.runActivity(named: "Unconditional evaluation") { _ in
            XCTContext.runActivity(named: "if true then t2 else t3 -> t2") { _ in
                let vSucc = Term.succ(fi, .zero(fi))
                let ifTrue = Term.if(fi, .true(fi), vSucc, .zero(fi))
                let result = Evaluator.eval(ifTrue)
                XCTAssertEqual(result, vSucc)
            }

            XCTContext.runActivity(named: "if false then t2 else t3 -> t3") { _ in
                let vZero = Term.zero(fi)
                let ifFalse = Term.if(fi, .false(fi), .succ(fi, .zero(fi)), vZero)
                let result = Evaluator.eval(ifFalse)
                XCTAssertEqual(result, vZero)
            }

            XCTContext.runActivity(named: "pred 0 -> 0") { _ in
                let pred = Term.pred(fi, .zero(fi))
                let result = Evaluator.eval(pred)
                XCTAssertEqual(result, Term.zero(fi))
            }

            XCTContext.runActivity(named: "pred (succ nv) -> nv") { _ in
                let predSucc = Term.pred(fi, .succ(fi, .zero(fi)))
                let result = Evaluator.eval(predSucc)
                XCTAssertEqual(result, Term.zero(fi))
            }

            XCTContext.runActivity(named: "iszero 0 -> true") { _ in
                let isZero = Term.isZero(fi, .zero(fi))
                let result = Evaluator.eval(isZero)
                XCTAssertEqual(result, Term.true(fi))
            }

            XCTContext.runActivity(named: "iszero (succ nv) -> false") { _ in
                let isZero = Term.isZero(fi, .succ(fi, .zero(fi)))
                let result = Evaluator.eval(isZero)
                XCTAssertEqual(result, Term.false(fi))
            }
        }

        XCTContext.runActivity(named: "Conditional evaluation") { _ in
            XCTContext.runActivity(named: "t1 -> t1' | if t1 then t2 else t3 -> if t1' then t2 else t3") { _ in
                let vSucc = Term.succ(fi, .zero(fi))
                let if1 = Term.if(fi, .isZero(fi, .zero(fi)), vSucc, .zero(fi))
                let result = Evaluator.eval(if1)
                XCTAssertEqual(result, vSucc)
            }

            XCTContext.runActivity(named: "t1 -> t1' | succ t1 -> succ t1'") { _ in
                let succ = Term.succ(fi, .pred(fi, .succ(fi, .zero(fi))))
                let result = Evaluator.eval(succ)
                XCTAssertEqual(result, Term.succ(fi, .zero(fi)))
            }

            XCTContext.runActivity(named: "t1 -> t1' | pred t1 -> pred t1'") { _ in
                let pred = Term.pred(fi, .pred(fi, .succ(fi, .zero(fi))))
                let result = Evaluator.eval(pred)
                XCTAssertEqual(result, .zero(fi))
            }

            XCTContext.runActivity(named: "t1 -> t1' | iszero t1 -> iszero t1'") { _ in
                let isZero = Term.isZero(fi, .pred(fi, .succ(fi, .zero(fi))))
                let result = Evaluator.eval(isZero)
                XCTAssertEqual(result, .true(fi))
            }
        }
    }

}
