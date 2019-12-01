//
//  Term.swift
//  tapl-impl
//
//  Created by kagemiku on 2019/11/30.
//  Copyright © 2019 kagemiku. All rights reserved.
//

import Foundation

typealias FI = FileInformation

indirect enum Term: Equatable {
    case `true`(FI)
    case `false`(FI)
    case `if`(FI, Term, Term, Term)
    case zero(FI)
    case succ(FI, Term)
    case pred(FI, Term)
    case isZero(FI, Term)

}

extension Term {

    var isVal: Bool {
        switch self {
        case .true, .false:
            return true
        case let t where t.isNumericVal:
            return true
        default:
            return false
        }
    }

    var isNumericVal: Bool {
        switch self {
        case .zero:
            return true
        case .succ(_, let t1):
            return t1.isNumericVal
        default:
            return false
        }
    }

}
