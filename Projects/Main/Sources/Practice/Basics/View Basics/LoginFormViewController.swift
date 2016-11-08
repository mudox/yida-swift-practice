
//  LoginFormViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 03/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftValidators
import SwiftMessages
// import CrossroadRegex

fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class LoginFormViewController: UIViewController {

	// MARK: - Validation Specs
	lazy var nameValidation: Observable<String?> = {
		self.nameTextField.rx.text.map {
			(newText: String?) -> String? in
			return self.validations[self.nameTextField]!.validate()
		}.skip(1)
	}()

	lazy var numberValidation: Observable<String?> = {
		self.numberTextField.rx.text.map {
			(newText: String?) -> String? in
			return self.validations[self.numberTextField]!.validate()
		}.skip(1)
	}()

	lazy var validations: [UITextField: FieldValidation] = [
		self.nameTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员姓名"
			),
		]),

		self.numberTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员编号"
			),
			Validation(
				validator: Validators.regex("YD-\\d{4}-\\d{4}"),
				message: "请符合如下格式：YD-2016-0026"
			),
		]),

		self.passwordTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员密码"
			),
			Validation(
				validator: Validators.isAlphanumeric(),
				message: "密码只接受数字和字母"
			),
			Validation(
				validator: Validators.minLength(6),
				message: "密码长度不能小于6"
			),
		]),

		self.phoneNumberTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员手机号码(限中国大陆)"
			),
			Validation(
				validator: Validators.isPhone(.zh_CN),
				message: "无效的手机号码"
			),
		]),

		self.birthdayTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员出生日期"
			),
			Validation(
				validator: Validators.isDate("yyyy年-MM月-dd日"),
				message: "无效的日期格式"
			),
		]),

		self.addressTextField: FieldValidation(units: [
			Validation(
				validator: Validators.required(),
				message: "请填写学员的联系地址"
			),
		]),

		self.emailTextField: FieldValidation(units: [
			Validation(
				validator: Validators.isEmpty() || Validators.isEmail(),
				message: "无效的邮件地址格式"
			),
		]),
	]

	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var scrollView: UIScrollView!

	@IBOutlet weak var headerImageView: UIImageView!
	@IBOutlet weak var avatarImageView: UIImageView!

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var genderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var numberTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var phoneNumberTextField: UITextField!
	@IBOutlet weak var birthdayTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!

	@IBOutlet weak var registerButton: UIButton!

	let disposeBag = DisposeBag()

	var activeTextField: UITextField?

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		initSubviews()

		setupRegisterButton()

		theNotificationCenter.rx
			.notification(.UIKeyboardWillChangeFrame)
			.subscribe(onNext: { notify in
				self.handleKeyboardNotification(notify)
		}).addDisposableTo(disposeBag)

		// Rx
		inspectKeybaordNotifications()
		configureBackButton()
	}

	func handleKeyboardNotification(_ notify: Notification) {
		var keyboardFrame = (notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		keyboardFrame = theWindow.convert(keyboardFrame, from: nil)
		let coveredArea = theWindow.bounds.intersection(keyboardFrame)

		scrollView.contentInset.bottom = coveredArea.height
		scrollView.scrollIndicatorInsets.bottom = coveredArea.height
	}

	// MARK: UI Setup

	lazy var dateInputView: UIDatePicker = {
		let picker = UIDatePicker()
		picker.accessibilityIdentifier = "date input picker"

		picker.datePickerMode = .date
		picker.locale = Locale(identifier: "zh_Hans_CN")
		picker.maximumDate = Date()

		picker.rx.date.subscribe(onNext: {
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy年-MM月-dd日"
			self.birthdayTextField.text = formatter.string(from: $0)

		}).addDisposableTo(self.disposeBag)

		return picker
	}()

	lazy var dateInputAccessoryView: UIView = {
		let view = UIView(frame: theWindow.bounds)
		view.bounds.size.height = 34

		view.tintColor = .black
		view.backgroundColor = #colorLiteral(red: 0.8012459874, green: 0.7945653796, blue: 0.7944134474, alpha: 1)

		let button = UIButton(type: .system)
		let attributes = [
			NSFontAttributeName: UIFont.systemFont(ofSize: 18),
			NSForegroundColorAttributeName: UIColor.black,
		]
		let attributedTitle = NSAttributedString(string: "确定", attributes: attributes)
		button.setAttributedTitle(attributedTitle, for: .normal)

		button.rx.tap.subscribe(onNext: {
			self.focusOnNextField(of: self.birthdayTextField)
		}).addDisposableTo(self.disposeBag)

		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8),
			button.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
			view.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
		])

		return view
	}()

	let placeholderText = [
		"必填",
		"必填，格式：YD-2016-3838",
		"必填，不小于6个字符",
		"必填，限中国大陆号码",
		"必填，点击选择出生年月",
		"必填",
		"可选",
	]

	let textFieldTagRange = 99 ... 105

	var textFields: [UITextField] {
		return textFieldTagRange.map {
			self.view.viewWithTag($0) as! UITextField
		}
	}

	let messageViewTagRange = 199 ... 205

	var messageViews: [UILabel] {
		return messageViewTagRange.map {
			self.view.viewWithTag($0) as! UILabel
		}
	}

	func messageView(for textField: UITextField) -> UILabel {
		return view.viewWithTag(textField.tag + 100) as! UILabel
	}

	let placeholderViewTag = 1000

	func placeholderView(for textField: UITextField) -> UILabel {
		return textField.viewWithTag(placeholderViewTag) as! UILabel
	}

	func initSubviews() {

		// interface from top to bottom

		// header image view
		headerImageView.layer.cornerRadius = 10
		headerImageView.addSubview(avatarImageView)

		// text fields
		for tag in textFieldTagRange {
			// clear button for each text field
			let clearButton = UIButton(type: .custom)
			clearButton.setImage(#imageLiteral(resourceName: "Clear"), for: .normal)
			clearButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
			clearButton.tintColor = .lightGray
			clearButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)

			clearButton.rx.tap
				.subscribe(onNext: { [weak self] _ in
					self?.activeTextField?.text = ""
			}).addDisposableTo(disposeBag)

			let textField = view.viewWithTag(tag) as! UITextField
			textField.rightView = clearButton
			textField.rightViewMode = .whileEditing
			textField.clearButtonMode = .never

			// placeholder text for each text field
			let label = UILabel()
			label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
			label.textColor = .darkGray
			label.text = placeholderText[tag - 99]

			label.tag = placeholderViewTag
			textField.addSubview(label)
			label.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				label.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
				label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
			])
		}

		// hide all message views
		messageViewTagRange.map { self.view.viewWithTag($0)! }.forEach { $0.isHidden = true }

		registerButton.layer.cornerRadius = 3
	}
}

// MARK: - as UITextFieldDelegate
extension LoginFormViewController: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if textField === birthdayTextField {
			textField.inputView = dateInputView
			textField.inputAccessoryView = dateInputAccessoryView
		}
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		activeTextField = textField

		// hide placeholder view
		placeholderView(for: textField).isHidden = true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		activeTextField = nil

		validate(textField)

		// show placeholder view if input is empty
		textField.viewWithTag(placeholderViewTag)?.isHidden = textField.hasText
	}

	func focusOnNextField(of textField: UITextField) {
		if textField.tag == textFieldTagRange.upperBound {
			textField.resignFirstResponder()
		} else {
			view.viewWithTag(textField.tag + 1)!.becomeFirstResponder()
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// enter to go to next field

		focusOnNextField(of: textField)
		return true
	}
}

// MARK: - Form validation
extension LoginFormViewController {

	struct ValidationUnit {
		var validator: Validator
		var message: String

		func validate(_ text: String?) -> String? {
			if validator(text) {
				return nil
			} else {
				return message
			}
		}
	}

	struct FieldValidation {
		var units: [ValidationUnit]

		func validate(_ text: String) -> String? {
			for unit in units {
				if let message = unit.validate(text) {
					return message
				}
			}
			return nil
		}
	}

	func showMessage(_ message: String, for textField: UITextField) {
		let label = messageView(for: textField)
		label.text = message

		label.isHidden = false
		scrollView.scrollRectToVisible(scrollView.convert(label.bounds, from: label), animated: true)
	}

	func hideMessageView(for textField: UITextField) {
		let label = messageView(for: textField)
		label.isHidden = true
	}

	/** 
   Show message label under if validation failed, hide the label otherwise

   - parameter textField: the text field to validate
   */
	func validate(_ textField: UITextField) {
		for validation in validations[textField]! {
			if let message = validation.validate(textField.text) {
				showMessage(message, for: textField)
				break
			} else {
				hideMessageView(for: textField)
			}
		}

		// refresh register button
		var enabled = true
		for hidden in (messageViews.map { $0.isHidden }) {
			if !hidden {
				enabled = false
				break
			}
		}
		enableRegisterButton(enabled)
	}

	func enableRegisterButton(_ enabled: Bool = true) {
		registerButton.isEnabled = enabled

		if enabled {
			registerButton.backgroundColor = .orange
		} else {
			registerButton.backgroundColor = .lightGray
		}
	}
}

// MARK: - Using RxSwift
extension LoginFormViewController {

	func inspectKeybaordNotifications() {
		for name: Notification.Name in [
				.UIKeyboardWillShow, .UIKeyboardDidShow,
				.UIKeyboardWillChangeFrame, .UIKeyboardDidChangeFrame,
				.UIKeyboardWillHide, .UIKeyboardDidHide,
		] {
			theNotificationCenter.rx
				.notification(name)
				.subscribe(onNext: { notify in
					if let beginFrame = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
						let endFrame = (notify.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
							let text = "\n\(beginFrame.shortDescription) -> \(endFrame.shortDescription)"
							jack.debug(text, withPrefix: .text("\(name.rawValue)"))
					}
			}).addDisposableTo(disposeBag)
		}
	}

	func configureBackButton() {
		backButton.tintColor = .darkGray
		backButton.rx.tap.subscribe(onNext: { [weak self] in
			self?.dismiss(animated: true, completion: nil)
		}).addDisposableTo(disposeBag)
	}

	func setupRegisterButton() {
		registerButton.rx.tap.subscribe(onNext: {
			self.activeTextField?.resignFirstResponder()

			let gender = (self.genderSegmentedControl.selectedSegmentIndex == 0) ? "男" : "女"

			// calculate age
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy年-MM月-dd日"
			let birthday = dateFormatter.date(from: self.birthdayTextField.text!)!
			let age = "\(Int(Date().timeIntervalSince(birthday)) / (3600 * 365))"

			let title = "\(self.nameTextField.text!) \(gender)(\(age) 岁) \n"

			var body =
				"\n - 　　编号：\(self.numberTextField.text!) \n"
				+ " - 　　密码：\(self.passwordTextField.text!) \n"
				+ " - 电话号码：\(self.phoneNumberTextField.text!) \n"
				+ " - 联系地址：\(self.addressTextField.text!) "

			if self.addressTextField.text! != "" {
				body += "\n - 邮件地址：\(self.emailTextField.text!) "
			}

			body += "\n\n 下滑或点击暗影区域以撤下本消息框"

			let view = MessageView.viewFromNib(layout: .CardView)
			view.accessibilityIdentifier = "message view"

			view.configureTheme(.success)
			view.configureContent(title: title, body: body)

			view.iconImageView?.isHidden = true
			view.button?.isHidden = true
			view.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
			view.titleLabel?.textAlignment = .center
			view.bodyLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightUltraLight)

			var config = SwiftMessages.Config()
			config.presentationStyle = .bottom
			config.dimMode = .gray(interactive: true)
			config.duration = .forever

			SwiftMessages.show(config: config, view: view)

		}).addDisposableTo(disposeBag)
	}
}

