import UIKit

// MARK: - 할당 연산자
let color = "purple"
print(color)
//동시에 여러 변수에 값을 할당할 수 있다.
var a = 1, b = 2, c = 3

// MARK: - 저장 프로퍼티
let name = "철수"
//name = "영희" // 에러 발생
var name2 = "철수"
name2 = "영희" // 에러 발생하지 않음

// MARK: - 연산 프로퍼티
var x = 10
var y = 20
var sum: Int {
    return x + y
    // return 을 제외해도 가능
//    get {
//        return x + y
//    }
//    set{
//        sum = x + y
//    }
}

// MARK: - 텍스트, 문자 보간법
var text = "안녕하세요"
var text2 = """
안
녕
하
세
요
"""
print("나는 누구입니다. \(text)")

// MARK: - 함수
/*
 func 함수_이름(아규먼트_레이블: 파라미터_타입) -> 리턴_타입 {
  // ... 코드
 }
 함수는 수학에서 f(x) x를 입력받아 y를 출력하는 것과 비슷하다.
*/
func sayHi(friend: String) {
  print("Hi~ \(friend)!")
}
sayHi(friend: "영호")
func sayHi2(_ friend: String) -> String {
  return ("Hi~ \(friend)!")
}
print(sayHi2("영호"))
