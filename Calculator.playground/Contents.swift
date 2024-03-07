import Foundation

protocol Operation {
    func operate(firstNumber: Int, secondNumber: Int) -> Int
}
class AddOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber + secondNumber
    }
}

class SubstractOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber - secondNumber
    }
}

class MultiplyOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber * secondNumber
    }
}
class DivideOperation: Operation {
    func operate(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber / secondNumber
    }
}

class Calculator {
    private var operation: Operation?
    
    func setOperation(operation: Operation) {
        self.operation = operation
    }
    
    func calculate(firstNumber: Int, secondNumber: Int) -> Int? {
        guard let operation = operation else {
            return nil
        }
        return operation.operate(firstNumber: firstNumber, secondNumber: secondNumber)
    }
}


let calculator = Calculator()
// 더하기 연산 예시
calculator.setOperation(operation: AddOperation())
let sum = calculator.calculate(firstNumber: 10, secondNumber: 20)
print("더하기 결과: \(sum!)") // 출력: 30

// 빼기 연산 예시
calculator.setOperation(operation: SubstractOperation())
let difference = calculator.calculate(firstNumber: 25, secondNumber: 15)
print("빼기 결과: \(difference!)") // 출력: 10
