//
//  FirstViewController.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 12.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import UIKit
import EasyHTTP
import EasyGUI

class FirstViewController: UIViewController, HttpClient {

	@IBOutlet weak var txtQuestion: UILabel!
	@IBOutlet weak var txtAnswer: UITextField!
	@IBOutlet weak var txtResult: UILabel!
	
	private static let COMM_NEW_QUESTION = "NEW_QUESTION"
	private static let COMM_CHECK_ANSWER = "CHECK_ANSWER"
	
	var config: Config!
	var question: String!
	var hint: String!
	var command: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		config = Config()
	}

	@IBAction func send_click(_ sender: Any) {
		check_answer()
	}
	
	@IBAction func hint_click(_ sender: Any) {
		show_hint()
	}
	
	@IBAction func new_click(_ sender: Any) {
		load_new_question()
	}
	
	func handle_http_response(json: [String : Any]) {
		DispatchQueue.main.async {
			if self.command == FirstViewController.COMM_NEW_QUESTION {
				self.question = json["question"] as? String
				self.hint = json["hint"] as? String
				self.txtQuestion.text = self.question
			}
			else if self.command == FirstViewController.COMM_CHECK_ANSWER {
				let x = json["success"] as! String
				if x == "True" {
					self.txtResult.text = "✅"
				}
				else {
					self.txtResult.text = "🔴"
				}
			}
			self.view.isUserInteractionEnabled = true
		}
	}
	
	func handle_http_error(error: Error) {
		DispatchQueue.main.async {
			self.view.isUserInteractionEnabled = true
			Gui.showErrorPopup(error: error, parent: self)
		}
	}
	
	private func check_answer() {
		self.view.isUserInteractionEnabled = false
		command = FirstViewController.COMM_CHECK_ANSWER
		CozcukHttp().post(client: self, parameters: ["question": self.question, "answer": self.txtAnswer.text ?? ""], suffix: Config.SUFFIX_CHECK_ANSWER)
	}
	
	private func load_new_question() {
		self.view.isUserInteractionEnabled = false
		self.question = ""
		self.hint = ""
		self.txtQuestion.text = ""
		command = FirstViewController.COMM_NEW_QUESTION
		CozcukHttp().post(client: self, parameters: [:], suffix: Config.SUFFIX_GET_QUESTION)
	}
	
	private func show_hint() {
		self.txtQuestion.text = self.hint
	}
}

