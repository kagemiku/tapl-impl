//
//  Evaluator.swift
//  tapl-impl
//
//  Created by kagemiku on 2019/11/30.
//  Copyright © 2019 kagemiku. All rights reserved.
//

import Foundation

struct Evaluator {

    private static var dummyInfo: FileInformation {
        return FileInformation()
    }

    private static func eval1(_ t: Term) throws -> Term {
        switch t {
        case let .if(_, .true, t2, _):
            return t2

        case let .if(_, .false, _, t3):
            return t3

        case let .if(fi, t1, t2, t3):
            let st1 = try eval1(t1)
            return .if(fi, st1, t2, t3)

        case let .succ(fi, t1):
            let st1 = try eval1(t1)
            return .succ(fi, st1)

        case .pred(_, .zero):
            return .zero(dummyInfo)

        case let .pred(_, .succ(_, t1)) where t1.isNumericVal:
            return t1

        case let .pred(fi, t1):
            let st1 = try eval1(t1)
            return .pred(fi, st1)

        case .isZero(_, .zero):
            return .true(dummyInfo)

        case let .isZero(_, .succ(_, t1)) where t1.isNumericVal:
            return .false(dummyInfo)

        case let .isZero(fi, t1):
            let st1 = try eval1(t1)
            return .isZero(fi, st1)

        default:
            throw EvaluationError.noRuleApplies
        }
    }

    static func eval(_ t: Term) -> Term {
        do {
            let term = try eval1(t)
            return eval(term)
        } catch EvaluationError.noRuleApplies {
            return t
        } catch {
            fatalError()
        }
    }

}
