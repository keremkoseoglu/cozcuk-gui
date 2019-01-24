//
//  User.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import UIKit

class User: UIViewController, HttpClient {

	@IBOutlet weak var txtUsername: UITextField!
	@IBOutlet weak var txtPassword2: UITextField!
	@IBOutlet weak var txtEmail: UITextField!
	@IBOutlet weak var txtPassword1: UITextField!
	@IBOutlet weak var txtPasswordStatus: UILabel!
	@IBOutlet weak var txtUserStatus: UILabel!
	@IBOutlet weak var txtEmailStatus: UILabel!
	
	static private let STATUS_ERROR = "🔴"
	static private let STATUS_OK = "✅"
	
	var form_is_valid = true
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func cancel_clicked(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func save_clicked(_ sender: Any) {
		validate_form()
		if !form_is_valid { return }

		self.view.isUserInteractionEnabled = false
		
		Http().post(
			client: self,
			parameters: [
				"_username": txtUsername.text!,
				"_password": txtPassword1.text!,
				"email": txtEmail.text!
			],
			url: Config().get_url(suffix: Config.SUFFIX_ADD_USER)
		)
	}
	
	func handle_http_response(json: [String : Any]) {
		
		/*
		TODO
		- başarılıysa user settings'i güncelle
		- bir önceki form yeni user settings'i gösteriyor olsun döndüğünde
		*/
		
		dismiss(animated: true, completion: nil)
	}
	
	func handle_http_error(error: Error) {
		DispatchQueue.main.async {
			self.view.isUserInteractionEnabled = true
			Gui.show_error_popup(error: error, parent: self)
		}
	}
	
	private func validate_form() {
		form_is_valid = true
		
		if txtUsername.text != "" {
			txtUserStatus.text = User.STATUS_OK
		}
		else {
			txtUserStatus.text = User.STATUS_ERROR
			form_is_valid = false
		}
		
		if txtPassword1.text != "" && txtPassword1.text == txtPassword2.text {
			txtPasswordStatus.text = User.STATUS_OK
		}
		else {
			txtPasswordStatus.text = User.STATUS_ERROR
			form_is_valid = false
		}
		
		if txtEmail.text != "" && Gui.is_email_valid(email: txtEmail.text ?? "") {
			txtEmailStatus.text = User.STATUS_OK
		}
		else {
			txtEmailStatus.text = User.STATUS_ERROR
			form_is_valid = false
		}
		
	}
	
	/*
	// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
