//
//  SignUpVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/02.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldAge: UITextField!
    @IBOutlet weak var txtFieldUserID: UITextField!
    @IBOutlet weak var txtFieldPW: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func btnNewUser(_ sender: UIButton) {
//        let url = "http://10.156.147.206:8080/users/signup" //학교
        let url = "http://13.209.66.51:8080/users/signup"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        
        // POST 로 보낼 정보
        let params: Parameters = [
            "userId" : txtFieldUserID.text!,
            "userAge" : Int(txtFieldAge.text!) ?? 0,
            "userName" : txtFieldName.text!,
            "userPw" : txtFieldPW.text!
        ] as Dictionary

        
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
                let successOnAlert = UIAlertController(title: "안내", message: "회원가입 성공!", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "로그인 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                debugPrint(response)
                let failOnAlert = UIAlertController(title: "안내", message: "이미 존재하는 사용자입니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "로그인 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
        
        
    }
    
}
    


