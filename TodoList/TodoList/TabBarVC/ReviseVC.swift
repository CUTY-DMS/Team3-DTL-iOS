//
//  ReviseVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/29.
//

import UIKit
import Alamofire

class ReviseVC: UIViewController {
    @IBOutlet weak var txtFieldReviseTitle: UITextField!
    @IBOutlet weak var txtViewReviseContent: UITextView!
    @IBOutlet weak var btnStateCheck: UIButton!
    
    var reviseTitle: String = ""
    var reviseContent: String = ""
    var reviseState: Bool = false
    var reviseID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtFieldReviseTitle.text = "\(reviseTitle)"
        txtViewReviseContent.text = "\(reviseContent)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (reviseState == true) {
            let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
            
            btnStateCheck.setImage(successImage, for: .normal)
        }
        
    }
    
    
    @IBAction func btnMyTodoState(_ sender: UIButton) {
        if (reviseState == true) {
            sender.titleLabel?.textColor = UIColor(named: "MainColor")
            let config = UIImage.SymbolConfiguration(
                pointSize: 20, weight: .regular, scale: .default)
            let image = UIImage(systemName: "square", withConfiguration: config)
            sender.setImage(image, for: .normal)
        }
        
        else if (reviseState == false) {
            sender.titleLabel?.textColor = UIColor(named: "MainColor")
            let config = UIImage.SymbolConfiguration(
                pointSize: 20, weight: .regular, scale: .default)
            let image = UIImage(systemName: "checkmark.square.fill", withConfiguration: config)
            sender.setImage(image, for: .normal)
        }
        
        
        let url = "http://13.209.66.51:8080/users/my/\(reviseID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .patch
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")
        
        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.result {
            case .success:
                debugPrint(response)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func btnRevise(_ sender: UIButton) {
        let txtFieldReviseTitle = self.txtFieldReviseTitle.text
        let txtViewReviseContent = self.txtViewReviseContent.text
        
        //전송할 값
        let url = "http://13.209.66.51:8080/users/my/\(reviseID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .put
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")
        
       
        let params = ["title" : txtFieldReviseTitle!,
                      "content" : txtViewReviseContent!] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            
        } catch {
            print("http Body Error")
        }

        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.result {
            case .success:
                debugPrint(response)
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 수정 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "마이페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 수정 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "상세보기 화면으로", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func btnTodoDelete(_ sender: UIButton) {
        let url = "http://13.209.66.51:8080/users/my/\(reviseID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .delete
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")

        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.result {
            case .success:
                debugPrint(response)
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 삭제 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "마이페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 삭제 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "상세보기 화면으로", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }
    
    
}
