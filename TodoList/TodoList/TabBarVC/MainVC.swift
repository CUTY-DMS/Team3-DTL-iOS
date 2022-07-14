//
//  MainVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/03.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        
        return f
    }()
    
//    var result: [Content] = []
    var result: [MainPostModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        getUsers()
    }
    
    private func getUsers() {
        AF.request("http://10.156.147.206:8080/post/main", method: .get)
            .validate(statusCode: 200..<500)
            .responseData {
                response in switch response.result {
                case.success:
                    print(response.result)
                    debugPrint(response)
                    if let data = try? JSONDecoder().decode([MainPostModel].self, from: response.data!){
                        print(data)
                        DispatchQueue.main.async {
                            self.result = data
                            self.listTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
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
        return cell
    }

}
