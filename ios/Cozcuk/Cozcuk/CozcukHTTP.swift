//
//  CozcukHTTP.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.04.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import Foundation
import EasyHTTP

class CozcukHttp {
	
	private var config: Config!
	private var http: Http!
	
	init() {
		config = Config()
		http = Http()
	}
	
	func post(client: HttpClient, parameters: [String: String], suffix: String) {
		var param = ["username": self.config.get_user(), "password": self.config.get_password()]
		parameters.forEach { (k,v) in param[k] = v }
		let url = self.config.get_url(suffix: suffix)
		http.post(client: client, parameters: param, url: url)
	}
	
}
