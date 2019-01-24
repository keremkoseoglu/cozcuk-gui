//
//  Http.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import Foundation

protocol HttpClient {
	func handle_http_error(error: Error)
	func handle_http_response(json: [String: Any])
}

class Http {
	
	func get(client: HttpClient, parameters: [String: String], url: String) {
		
		// Set URL
		var complete_url = url
		if parameters.count > 0 {
			complete_url += "?"
			for p in parameters {
				complete_url += p.key + "=" + p.value + "&"
			}
		}
		
		let url2 = URL(string: complete_url)!
		
		// Set Request
		var request = URLRequest(url: url2)
		request.httpMethod = "GET" //set http method as GET
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		// Fire
		start_request(client: client, request: request)
		
	}
	
	func post(client: HttpClient, parameters: [String: String], url: String) {
		
		// Set URL
		let url2 = URL(string: url)!
		
		// Set Request
		var request = URLRequest(url: url2)
		request.httpMethod = "POST"
		
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
		} catch let error {
			print(error.localizedDescription)
		}
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		// Fire
		start_request(client: client, request: request)
	}
	
	private func start_request(client: HttpClient, request: URLRequest) {
		
		let session = URLSession.shared
		
		//create dataTask using the session object to send data to the server
		let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
			
			guard error == nil else {
				client.handle_http_error(error:error!)
				return
			}
			guard let data = data else { return }
			
			do {
				//create json object from data
				if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
					client.handle_http_response(json: json)
				}
			} catch let error {
				client.handle_http_error(error:error)
			}
		})
		task.resume()
		
	}
	
}

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
