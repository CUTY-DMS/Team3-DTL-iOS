//
//  MainVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/03.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var listTableView: UITableView!
    
    var result: [MainPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listTableView.delegate = self
        listTableView.dataSource = self
      
        listTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 20)
        
        getPostList()
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getPostList()
        
        refreshControl.endRefreshing() // 초기화 - refresh 종료
    }
    
    
    private func getPostList() {
//        AF.request("http://10.156.147.206:8080/post/main", method: .get) //학교
        AF.request("http://13.209.66.51:8080/post/main", method: .get)
            .validate(statusCode: 200..<500)
            .responseData {
                response in switch response.result {
                case .success:
                    print(response.result)
                    debugPrint(response)
                    if let data = try? JSONDecoder().decode([MainPostModel].self, from: response.data!){
                        print(data)
                        DispatchQueue.main.async {
                            self.result = data
                            self.listTableView.reloadData()
                            
                            self.listTableView.refreshControl = UIRefreshControl()
                            self.listTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                            self.refreshControl.endRefreshing() // 초기화 - refresh 종료
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                    self.listTableView.refreshControl = UIRefreshControl()
                    self.listTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                    self.refreshControl.endRefreshing() // 초기화 - refresh 종료
                }
            }
    
    }
}


extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TodoListCell
        cell.lbUser.text = "\(result[indexPath.row].member_id)"
        cell.lbTitle.text = "\(result[indexPath.row].title)"
        cell.lbDate.text = "\(result[indexPath.row].created_at)"
        
        if (result[indexPath.row].todo_success == false) {
            cell.checkBoxBtn.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        else if (result[indexPath.row].todo_success == true) {
            cell.checkBoxBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listTableView.deselectRow(at: indexPath, animated: true)
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        view.postTitle = "\(result[indexPath.row].title)"
        view.postWriter = "\(result[indexPath.row].member_id)"
        view.txt = "\(result[indexPath.row].content)"
        view.id = result[indexPath.row].id
        view.likeCount = result[indexPath.row].like_count
        view.createdDate = "\(result[indexPath.row].created_at)"
        view.successResult = result[indexPath.row].todo_success
        
        navigationController?.pushViewController(view, animated: true)
    }
    
}
