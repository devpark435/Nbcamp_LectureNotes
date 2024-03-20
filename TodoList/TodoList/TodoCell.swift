//
//  TodoCell.swift
//  TodoList
//
//  Created by 박현렬 on 3/19/24.
//

import UIKit
class TodoCell: UITableViewCell {
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    var todo: Todo?
    @IBAction func switchValueChanged(_ sender: UISwitch) {
            todo?.isCompleted = sender.isOn // Todo 모델 업데이트
            // 스위치 상태에 따라 텍스트 색상 변경
            if sender.isOn {
                titleLabel.textColor = .gray
                todo?.isCompleted = true
                titleLabel.text =  "\(todo?.title ?? "") 완료👍"
            } else {
                titleLabel.textColor = .black
                todo?.isCompleted = false
                titleLabel.text =  "\(todo?.title ?? "")"}
        }
}
