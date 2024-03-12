//
//  main.swift
//  BullsAndCows
//
//  Created by 박현렬 on 3/12/24.
//

import Foundation
// MARK: -  야구 게임 클래스 호출
let game = BaseballGame()
game.start()

// MARK: - 야구 게임 클래스
class BaseballGame {
    // 게임 시작 함수
    func start() {
        let answer = makeAnswer()
        print("정답: \(answer)")
    }
    // 정답 생성 함수
    func makeAnswer() -> Int {
        // 1~9 랜덤 3자리 숫자
        return Int.random(in: 111...999)
    }
}

