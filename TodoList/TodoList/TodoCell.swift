//
//  TodoCell.swift
//  TodoList
//
//  Created by 박현렬 on 3/19/24.
//

import UIKit
import SnapKit
import Then

class TodoCell: UITableViewCell {
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryColor: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    var todo: Todo?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
        setUI()
    }
    //MARK: - UI 설정
    private func setUI(){
        dateLabel.do {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .gray
            $0.textAlignment = .right
        }
    }
    //MARK: - 제약조건 설정
    private func setupConstraints() {
        // categoryColor의 제약 조건 설정
        categoryColor.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(5)
        }
        
        // titleLabel의 제약 조건 설정
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryColor.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
        
        // dateLabel의 제약 조건 설정
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        // switchButton의 제약 조건 설정
        switchButton.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        // titleLabel의 압축 저항 우선순위 설정
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // dateLabel의 허깅 우선순위 설정
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // switchButton의 허깅 우선순위 설정
        switchButton.setContentHuggingPriority(.required, for: .horizontal)
    }
    //MARK: - 스위치 버튼 값 변경 시 호출되는 메서드
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        todo?.isCompleted = sender.isOn // Todo 모델 업데이트
        // 스위치 상태에 따라 텍스트 색상 변경
        if sender.isOn {
            titleLabel.textColor = .gray
            todo?.isCompleted = true
            titleLabel.text =  "\(todo?.title ?? "") 완료👍"
            categoryColor.backgroundColor = .red
        } else {
            titleLabel.textColor = .black
            todo?.isCompleted = false
            titleLabel.text =  "\(todo?.title ?? "")"
            categoryColor.backgroundColor = .green
        }
        
    }
}
