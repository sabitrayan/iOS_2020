//
//  Calculator.swift
//  CalculatorProject
//
//  Created by erumaru on 1/25/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        //case random(function: ()->Double)
        case clear
        //case acclear
        //case pi(function: ()->Double)
        
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "*" : .binary { $0 * $1},
        "=" : .equals,
        "/" : .binary { $0 / $1},
        "%" : .unary { $0 / 100 },
        "sqrt" : .unary { sqrt($0) },
        "pi" : .constant(value: Double.pi) ,
        "random" : .constant(value: Double.random(in: 0...100)),
        "ac" : .clear,
        "c" : .constant(value: 0),
        "!" : .unary { factorial($0) },
//        "!" :  .unary { n in
//                  if n == 0 {
//                      return 1
//                  }
//                  var a: Double = 1
//                  for i in 1...Int(n) {
//                      a *= Double(i)
//                  }
//                  return a
//              },
        "^" : .binary { pow($0,$1) }
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    static func factorial(_ factorialNumber: Double) -> Double {
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber - 1)
        }
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .clear:
            result = 0
            lastBinaryOperation = nil
            reminder = 0
//        case .acclear:
//            reminder = 0;
//            lastBinaryOperation = nil
//        case .random(let function):
//            result = function()
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary(let function):
            lastBinaryOperation = function
            reminder = result
            
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
        }
    }
}
