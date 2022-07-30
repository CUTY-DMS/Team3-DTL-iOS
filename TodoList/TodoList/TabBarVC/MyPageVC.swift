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
    @IBOutlet weak var lbMyName: UILabel!
    @IBOutlet weak var lbMyAge: UILabel!
    
    var myPosts = MyPostModel()
    
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myPostsTableView.delegate = self
        myPostsTableView.dataSource = self
        
        myPostsTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 20)
       
        getMyPostList()
    }
    
    @IBAction func btnSignOut(_ sender: UIButton) {
        guard let signOut = self.storyboard?.instantiateViewController(identifier: "LogInVC") as? LogInVC else { return }
        
        signOut.modalPresentationStyle = .fullScreen
        self.present(signOut, animated: true, completion: nil)
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getMyPostList()
    }
    
    
    private func getMyPostList() {
//        let url = "http://10.156.147.206:8080/users/my" //학교
        let url = "http://13.125.180.241:8080/users/my"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue("\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")
        
        
        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
            
                if let data = try? JSONDecoder().decode(MyPostModel.self, from: response.data!) {
                    DispatchQueue.main.async {
                        print(data)
                        
                        self.myPosts = data
                        self.myPostsTableView.reloadData()
                        
                        self.myPostsTableView.refreshControl = UIRefreshControl()
                        self.myPostsTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                        self.myRefreshControl.endRefreshing()
                    }
                }
            
            case .failure(let error):
                print(error)
            
                self.myPostsTableView.refreshControl = UIRefreshControl()
                self.myPostsTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    
}


extension MyPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPosts.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myPostCell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as! MyPostsCell

        myPostCell.lbMyPostTitle.text = "\(myPosts.todos[indexPath.row].title)"
        myPostCell.lbMyPostDate.text = "\(myPosts.todos[indexPath.row].created_at)"

        lbMyName.text = "\(myPosts.user_name)"
        lbMyAge.text = "\(myPosts.user_age)세"
        

        if (myPosts.todos[indexPath.row].success == false) {
            myPostCell.todoStateBtn.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        else if (myPosts.todos[indexPath.row].success == true) {
            myPostCell.todoStateBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }

        return myPostCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPostsTableView.deselectRow(at: indexPath, animated: true)
        
        guard let myDetail = self.storyboard?.instantiateViewController(withIdentifier: "MyDetailVC") as? MyDetailVC else { return }
        
        myDetail.myTitle = "\(myPosts.todos[indexPath.row].title)"
        myDetail.myContent = "\(myPosts.todos[indexPath.row].content)"
        myDetail.date = "\(myPosts.todos[indexPath.row].created_at)"
        myDetail.state = myPosts.todos[indexPath.row].success
        myDetail.myID = myPosts.todos[indexPath.row].id
        myDetail.myLikesCount = myPosts.todos[indexPath.row].like_count
        
        navigationController?.pushViewController(myDetail, animated: true)
    }
    
    
}
