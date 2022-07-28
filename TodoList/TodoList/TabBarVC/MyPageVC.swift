//
//  MyPageVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/04.
//

import UIKit
import Alamofire

class MyPageVC: UIViewController {
    @IBOutlet weak var myPostsTableView: UITableView!
    
    let myRefreshControl = UIRefreshControl()
    
    var myPosts: [MyPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPostsTableView.delegate = self
        myPostsTableView.dataSource = self
        
        myPostsTableView.refreshControl = UIRefreshControl()
        myPostsTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        myRefreshControl.endRefreshing()
 
        myPostsTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 20)
        
        getMyPostList()
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        getMyPostList()
        myRefreshControl.endRefreshing() // 초기화 - refresh 종료
    }

    private func getMyPostList() {
//        let url = "http://10.156.147.206:8080/users/my" //학교
        let url = "http://13.125.180.241:8080/users/my"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")
       
        AF.request(request).response { (response) in switch response.result {
                case .success:
                    debugPrint(response)
    
                    if let data = try? JSONDecoder().decode([MyPostModel].self, from: response.data!){
                        DispatchQueue.main.async {
                            self.myPosts = data
                            self.myPostsTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}


extension MyPageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myPostCell = tableView.dequeueReusableCell(withIdentifier: "myPostsCell", for: indexPath) as! MyPostsCell
        myPostCell.lbMyPostTitle.text = "\(myPosts[indexPath.row].todos[indexPath.row].title)"
        myPostCell.lbMyPostDate.text = "\(myPosts[indexPath.row].todos[indexPath.row].created_at)"

        if (myPosts[indexPath.row].todos[indexPath.row].success == true) {
            myPostCell.todoStateBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }


        return myPostCell
    }

}
