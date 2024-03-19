//
//  ViewController.swift
//  TodoList
//
//  Created by 박현렬 on 3/19/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var todos: [Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Todo List"
        setLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        let todo1 = Todo(id: 1, title: "할 일 1", isCompleted: false)
        let todo2 = Todo(id: 1, title: "할 일 1", isCompleted: false)
        todos = [todo1, todo2]
    }
    func setLayout(){
        addButton.titleLabel?.text = "Add"
    }
    
}

