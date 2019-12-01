//
//  FileInformation.swift
//  tapl-impl
//
//  Created by kagemiku on 2019/11/30.
//  Copyright © 2019 kagemiku. All rights reserved.
//

import Foundation

struct FileInformation: Equatable {

    let line: Int

    init(line: Int = 0) {
        self.line = line
    }

}
