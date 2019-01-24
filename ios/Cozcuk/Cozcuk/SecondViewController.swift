//
//  SecondViewController.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 12.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class SecondViewController: UIViewController, LoginButtonDelegate, HttpClient {

	

	@IBOutlet weak var txtServer: UITextField!
	@IBOutlet weak var txtUser: UITextField!
	@IBOutlet weak var txtPassword: UITextField!
	
	var config: Config!
	
	override func viewDidLoad() {
		
		// Preparation
		super.viewDidLoad()
		config = Config()
		
		// Facebook stuff
		let loginButton = LoginButton(readPermissions: [ .publicProfile ])
		loginButton.center = view.center
		loginButton.delegate = self
		view.addSubview(loginButton)
		setup_oauth()
		
		// Values
		load_values()
	}

	func handle_http_error(error: Error) {
		// Şu anda sadece OAUTH'tan cevap bekliyoruz, kritik değil
	}
	
	func handle_http_response(json: [String : Any]) {
		// Şu anda sadece OAUTH'tan cevap bekliyoruz, kritik değil
	}
	
	func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
		setup_oauth()
	}
	
	func loginButtonDidLogOut(_ loginButton: LoginButton) {
		setup_oauth()
	}
	
	@IBAction func save_click(_ sender: Any) {
		save_values()
	}
	
	@IBAction func reset_click(_ sender: Any) {
		reset_values()
	}
	
	private func load_values() {
		txtServer.text = config.get_server()
		txtUser.text = config.get_user()
		txtPassword.text = config.get_password()
	}
	
	private func reset_values() {
		config.reset()
		load_values()
	}
	
	private func save_values() {
		config.set_server(server: txtServer.text!)
		config.set_user(user: txtUser.text!)
		config.set_password(password: txtPassword.text!)
	}
	
	private func setup_oauth() {
		
		if let accessToken = AccessToken.current {
			config.set_oauth(oauth: true)
			config.set_user(user: accessToken.userId!)
			config.set_password(password: accessToken.authenticationToken)
			
			txtUser.isUserInteractionEnabled = false
			txtPassword.isUserInteractionEnabled = false
			
			Http().get(
				client: self,
				parameters: [
					"oauth_username": config.get_user(),
					"oauth_token": config.get_password()
				],
				url: config.get_url(suffix:Config.SUFFIX_OAUTH)
			)

		}
		else {
			config.set_oauth(oauth: false)
			txtUser.isUserInteractionEnabled = true
			txtPassword.isUserInteractionEnabled = true
		}
	}
	
}

