//
//  LogInVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/02.
//

import UIKit
import Alamofire


class LogInVC: UIViewController {
    @IBOutlet weak var txtFieldUserID: UITextField!
    @IBOutlet weak var txtFieldPW: UITextField!
    @IBAction func btnLogIn(_ sender: UIButton) {
        signin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func signin() {
//        let url = "http://10.156.147.206:8080/users/signin" //학교
        let url = "http://13.125.180.241:8080/users/signin"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // POST 로 보낼 정보
        let params: Parameters = [
            "userId": "\(txtFieldUserID.text!)",
            "userPw": "\(txtFieldPW.text!)"
        ]

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: "AccessToken", token: data.AccessToken)
//                    KeyChain.create(key: "refreshToken", token: data.refreshToken)
                }
                
                guard let logInVC = self.storyboard?.instantiateViewController(identifier: "TabBarVC") else { return }

                logInVC.modalPresentationStyle = .fullScreen
                self.present(logInVC, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "입력을 다시 확인해주세요.", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }

    
}
