//
//  Configuration.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 17.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import Foundation

class Config {

	private static let DEFAULT_URL = "http://cozcuk-server.herokuapp.com"
	private static let KEY_OAUTH = "OAUTH"
	private static let KEY_SERVER = "SERVER"
	private static let KEY_USER = "USER"
	private static let KEY_PWD = "PWD"
	
	static let SUFFIX_ADD_USER = "/json/add_user"
	static let SUFFIX_CHECK_ANSWER = "/json/check_answer"
	static let SUFFIX_FORGOT_PWD = "/json/forgot_pwd"
	static let SUFFIX_GET_QUESTION = "/json/get_puzzle"
	static let SUFFIX_OAUTH = "/json/oauth"
	
	func get_oauth() -> Bool {
		return get_val(key:Config.KEY_OAUTH) == "X"
	}
	
	func get_password() -> String {
		return get_val(key:Config.KEY_PWD)
	}
	
	func get_server() -> String {
		return UserDefaults.standard.string(forKey: Config.KEY_SERVER) ?? Config.DEFAULT_URL
	}
	
	func get_url(suffix: String) -> String {
		return get_server() + suffix
	}
	
	func get_user() -> String {
		return get_val(key:Config.KEY_USER)
	}
	
	func reset() {
		set_server(server: Config.DEFAULT_URL)
		set_user(user: "")
		set_password(password: "")
	}
	
	func set_oauth(oauth:Bool) {
		var str_val = "X"
		if !oauth { str_val = "" }
		set_val(key:Config.KEY_OAUTH, value:str_val)
	}
	
	func set_password(password: String) {
		set_val(key:Config.KEY_PWD, value:password)
	}
	
	func set_server(server: String) {
		set_val(key:Config.KEY_SERVER, value:server)
	}
	
	func set_user(user: String) {
		set_val(key:Config.KEY_USER, value:user)
	}
	
	private func get_val(key: String, def_val: String = "") -> String {
		return UserDefaults.standard.string(forKey: key) ?? def_val
	}
	
	private func set_val(key: String, value: String) {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	
}
