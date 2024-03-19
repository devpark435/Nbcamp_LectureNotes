//
//  ViewController.swift
//  TodoList
//
//  Created by 박현렬 on 3/19/24.
//

import UIKit

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        let todo1 = Todo(id: 1, title: "할 일 1", isCompleted: false)
        let todo2 = Todo(id: 1, title: "할 일 1", isCompleted: false)
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
            
            // 입력된 내용을 처리하는 로직 추가
            let newTodo = Todo(id: (self?.todos.count ?? 0) + 1, title: newTodoTitle, isCompleted: false)
            self?.todos.append(newTodo)
            self?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        // 각 셀에 해당하는 Todo 데이터 가져오기
        let todo = todos[indexPath.row]
        
        // 셀에 Todo 제목 표시
        cell.textLabel?.text = todo.title
        
        return cell
    }
}
