//
//  NumberGenerator.swift
//  Task_7
//
//  Created by Kirill Asyamolov on 26/12/16.
//  Copyright © 2016 Kirill Asyamolov. All rights reserved.
//

class NumberGenerator {
    static func fibonacci(_ n: Int) -> Int {
        return n <= 2 ? 1 : fibonacci(n - 1) + fibonacci(n - 2)
    }
}
