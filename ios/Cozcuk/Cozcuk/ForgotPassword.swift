//
//  ForgotPassword.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import UIKit
import EasyHTTP
import EasyGUI

class ForgotPassword: UIViewController, HttpClient {
	
	func handle_http_response(json: [String : Any]) {
		dismiss(animated: true, completion: nil)
	}
	
	func handle_http_error(error: Error) {
		DispatchQueue.main.async {
			self.view.isUserInteractionEnabled = true
			Gui.showErrorPopup(error: error, parent: self)
		}
	}
	
	@IBAction func cancel_click(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBOutlet weak var txtUser: UITextField!
	private var config: Config!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		config = Config()
    }
    
	@IBAction func send_click(_ sender: Any) {
		self.view.isUserInteractionEnabled = false
		Http().get(client: self, parameters: ["uname": txtUser.text ?? ""], url: config.get_url(suffix: Config.SUFFIX_FORGOT_PWD))
	}

}
