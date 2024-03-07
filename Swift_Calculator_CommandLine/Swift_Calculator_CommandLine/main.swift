//
//  main.swift
//  Swift_Calculator_CommandLine
//
//  Created by 박현렬 on 3/7/24.
//

import Foundation
//Operation 프로토콜
protocol Operation {
    associatedtype ResultType
    func operate(firstNumber: Int, secondNumber: Int?) -> ResultType
}

// Operation 프로토콜을 채택한 클래스들
// MARK: - 더하기 연산 클래스
class AddOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber + (secondNumber ?? 0)
    }
}
// MARK: - 빼기 연산 클래스
class SubstractOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber - (secondNumber ?? 0)
    }
}
// MARK: - 곱하기 연산 클래스
class MultiplyOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber * (secondNumber ?? 0)
    }
}
// MARK: - 나누기 연산 클래스
class DivideOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber / (secondNumber ?? 0)
    }
}
// MARK: - 나머지 연산 클래스
class RemainOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber % (secondNumber ?? 0)
    }
}
// MARK: - 거듭제곱 연산 클래스
class PowerOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        var result = 1
        for _ in 0..<(secondNumber ?? 0) {
            result *= firstNumber
        }
        return result
    }
}
// MARK: - 평균 연산 클래스
class AverageOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Double {
        return Double((firstNumber + (secondNumber ?? 0))) / 2.0
    }
}
// MARK: - 제곱근 연산 클래스
class SquareRootOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Double {
        return sqrt(Double(firstNumber))
    }
}
// MARK: - 팩토리얼 연산 클래스
class FactorialOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        var result: Int = 1
        for i in 1...firstNumber {
            result *= i
        }
        return result
    }
}
// MARK: - 완전수 연산 클래스
class PerfectNumberOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Bool {
        var sum: Int = 0
        for i in 1..<firstNumber {
            if firstNumber % i == 0 {
                sum += i
            }
        }
        return sum == firstNumber
    }
}
// MARK: - 소수 연산 클래스
class PrimeNumberOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Bool {
        if firstNumber < 2 {
            return false
        }
        for i in 2..<firstNumber {
            if firstNumber % i == 0 {
                return false
            }
        }
        return true
    }
}
// MARK: - 소인수분해 연산 클래스
class FactorizationOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> [Int] {
        var result: [Int] = []
        var number = firstNumber
        var i = 2
        while number != 1 {
            if number % i == 0 {
                result.append(i)
                number /= i
            } else {
                i += 1
            }
        }
        return result
    }
}
// MARK: - 최대공약수 연산 클래스
class GCDOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        var a = firstNumber
        var b = secondNumber ?? 0
        while b != 0 {
            let r = a % b
            a = b
            b = r
        }
        return a
    }
}
// MARK: - 최소공배수 연산 클래스
class LCMOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return firstNumber * (secondNumber ?? 0) / GCDOperation().operate(firstNumber: firstNumber, secondNumber: secondNumber)
    }
}
// MARK: - 절대값 연산 클래스
class AbsoluteOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        return abs(firstNumber)
    }
}
// MARK: - 피보나치 연산 클래스
class FibonacciOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int?) -> Int {
        var a = 0
        var b = 1
        for _ in 0..<firstNumber {
            let temp = a
            a = b
            b = temp + b
        }
        return a
    }
}

// MARK: - 계산기 클래스
class Calculator {
    private var operation: (any Operation)?
    
    func setOperation(operation: any Operation) {
        self.operation = operation
    }
    
    func calculate(firstNumber: Int, secondNumber: Int) -> Any? {
        guard let operation = operation else {
            return nil
        }
        return operation.operate(firstNumber: firstNumber, secondNumber: secondNumber)as Any
    }
}

// MARK: - 입력, 계산, 출력 부분
let calculator = Calculator()
while true {
    // 사용자 입력 받기
    let input = readLine()
    guard let input = input else {
        fatalError("No input")
    }
    let components = input.components(separatedBy: " ")
    
    // 옵셔널 바인딩을 통한 숫자 추출
    guard let firstNumber = Int(components[0]) else {
        print("숫자를 입력해야 합니다.")
        exit(1)
    }
    let secondNumber: Int?
    if components.count == 3 {
        secondNumber = Int(components[2])
    } else if components.count == 2 {
        secondNumber = nil
    } else {
        print("잘못된 입력입니다.")
        exit(1)
    }
    
    // 연산자에 따른 Operation 객체 설정
    switch components[1] {
    case "+":
        calculator.setOperation(operation: AddOperation())
    case "-":
        calculator.setOperation(operation: SubstractOperation())
    case "*":
        calculator.setOperation(operation: MultiplyOperation())
    case "/":
        calculator.setOperation(operation: DivideOperation())
    case "%":
        calculator.setOperation(operation: RemainOperation())
    case "^":
        calculator.setOperation(operation: PowerOperation())
    case "avg":
        calculator.setOperation(operation: AverageOperation())
    case "sqrt":
        calculator.setOperation(operation: SquareRootOperation())
    case "!" :
        calculator.setOperation(operation: FactorialOperation())
    case "perfect" :
        calculator.setOperation(operation: PerfectNumberOperation())
    case "prime" :
        calculator.setOperation(operation: PrimeNumberOperation())
    case "gcd" :
        calculator.setOperation(operation: GCDOperation())
    case "lcm" :
        calculator.setOperation(operation: LCMOperation())
    case "abs" :
        calculator.setOperation(operation: AbsoluteOperation())
    case "fib" :
        calculator.setOperation(operation: FibonacciOperation())
    default:
        print("지원하지 않는 연산입니다.")
        exit(1)
    }
    
    // calculate() 결과 출력
    if let result = calculator.calculate(firstNumber: firstNumber, secondNumber: secondNumber ?? 0) {
        print("결과: \(result)")
    } else {
        print("계산 오류 발생")
    }
}
