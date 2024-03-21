//
//  ViewController.swift
//  TodoList
//
//  Created by 박현렬 on 3/19/24.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var todos: [Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Todo List"
        setLayout()
        addTarget()
        tableView.dataSource = self
        tableView.delegate = self
        let date = Date()
        let todo1 = Todo(id: 1, title: "할 일 1", isCompleted: false, date: date)
        let todo2 = Todo(id: 2, title: "할 일 2", isCompleted: true, date: date)
        todos = [todo1, todo2]
    }
    func setLayout(){
        addButton.setTitle("Add Todo", for: .normal)
    }
    func addTarget(){
        addButton.addTarget(self, action: #selector(addTodoTap), for: .touchUpInside)
    }
    @objc func addTodoTap() {
        let alertController = UIAlertController(title: "할 일 추가", message: "할 일을 입력하세요", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "할 일"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let newTodoTitle = textField.text,
                  !newTodoTitle.isEmpty else {
                // 입력된 내용이 없을 경우 처리
                return
            }
            let currentDate = Date()
            
            // 입력된 내용을 처리하는 로직 추가
            let newTodo = Todo(id: (self?.todos.count ?? 0) + 1, title: newTodoTitle, isCompleted: false, date: currentDate)
            self?.todos.append(newTodo)
            // 새로 추가된 행의 IndexPath 가져오기
                let newIndexPath = IndexPath(row: (self?.todos.count ?? 0) - 1, section: 0)
                
                // 새로운 행을 애니메이션과 함께 삽입
                self?.tableView.insertRows(at: [newIndexPath], with: .right)
//            self?.tableView.reloadData()
        }
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        // 각 셀에 해당하는 Todo 데이터 가져오기
        let todo = todos[indexPath.row]
        
        // 셀에 Todo 완료 여부 표시
        cell.switchButton.isOn = todo.isCompleted
        // 셀에 date 표시
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        let formattedDateString = dateFormatter.string(from: todo.date)
        cell.dateLabel.text = formattedDateString
        // 완료 여부에 따른 텍스트, 텍스트 색상 변경
        if todo.isCompleted {
            cell.titleLabel.textColor = .gray
            cell.titleLabel.text = todo.title + " 완료👍"
            cell.categoryColor.backgroundColor = .red
        } else {
            cell.titleLabel.textColor = .black
            cell.titleLabel.text = todo.title
            cell.categoryColor.backgroundColor = .green
        }
        // 셀에 Todo 데이터 저장
        cell.todo = todo
        return cell
    }
    // Cell 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    // 삭제 텍스트 변경
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
}
