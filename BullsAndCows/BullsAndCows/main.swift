//
//  main.swift
//  BullsAndCows
//
//  Created by 박현렬 on 3/12/24.
//

import Foundation
// MARK: -  야구 게임 클래스 호출
let game = BaseballGame()
game.mainMenu()

// MARK: - 야구 게임 클래스
class BaseballGame {
    // MARK: -  게임 기록 인스턴스 생성
    let gameRecord = gameRecordManager()
    // MARK: -  게임 메뉴 함수
    func mainMenu() {
        while true{
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            // 입력값에 따른 분기
            if let userInput = readLine(){
                switch userInput {
                case "1":
                    start()
                case "2":
                    gameRecord.printRecord()
                case "3":
                    print("< 숫자 야구 게임을 종료합니다 >")
                    // 게임 종료
                    exit(0)
                default:
                    // 잘못된 입력값일 경우
                    print("잘못된 입력입니다. 1, 2, 3 중 하나를 입력하세요.")
                }
            }
        }
    }
    // MARK: -  게임 시작 함수
    func start() {
        let answer = makeAnswer()
        // 시도 횟수 기록하는 변수 count
        var count = 0
        print("정답: \(answer)")
        // MARK: - 게임 진행 로직
        repeat {
            print("숫자를 입력하세요: ", terminator: "")
            // 입력받은 수 자리수 확인
            if let userInput = readLine(), userInput.count == 3 {
                // 입력받은 수를 정수 배열로 변환
                let userGuess = userInput.compactMap { Int(String($0)) }
                // 중복된 수가 없는지 확인
                if Set(userGuess).count == userGuess.count{
                    var strikes = 0
                    var balls = 0
                    // 입력받은 수와 정답 비교
                    for (index, digit) in userGuess.enumerated() {
                        if digit == answer[index] {
                            strikes += 1
                        } else if answer.contains(digit) {
                            balls += 1
                        }
                    }
                    //시도 횟수 증가
                    count += 1
                    // 둘다 0일 경우 Nothing 출력
                    if strikes == 0 && balls == 0 {
                        print("Nothing")
                    }
                    // 스트라이크와 볼이 있을 경우 출력
                    else{
                        print("\(strikes)스트라이크, \(balls)볼")
                    }
                    // 3스트라이크일 경우 정답 출력
                    if strikes == 3 {
                        print("축하합니다! 정답을 맞추셨습니다")
                        // 정답을 맞추면 시도횟수를 기록
                        gameRecord.addRecord(record: "\(count)번")
                        break
                    }
                }
                // 입력값이 0을 포함하거나 중복된 수가 있을 경우
                else{
                    print("올바르지 않은 입력값입니다.")
                }
            }
            // 입력값이 3자리 숫자가 아닐 경우
            else {
                print("올바르지 않은 입력값입니다. 3자리 숫자로 입력해주세요.")
            }
        } while true
    }
    // MARK: -  정답 생성 함수
    func makeAnswer() -> [Int] {
        var answer = [Int]()
        
        while answer.count < 3 {
            var digit = Int.random(in: 0...9)
            // 맨 앞자리가 0이 되지 않도록 보장
            while answer.isEmpty && digit == 0 {
                digit = Int.random(in: 0...9)
            }
            // 정답 숫자 중복 제거
            if !answer.contains(digit) {
                answer.append(digit)
            }
        }
        
        return answer
    }
}
// MARK: -  게임 기록 인스턴스 클래스
class gameRecordManager{
    var gameRecord = [String]()
    // MARK: -  게임 기록 추가 함수
    func addRecord(record: String){
        gameRecord.append(record)
    }
    // MARK: -  게임 기록 출력 함수
    func printRecord(){
        for (index, record) in gameRecord.enumerated(){
            print("\(index+1)번째 게임 : 시도 횟수 - \(record)")
        }
    }
}
