//
//  AddCategoryViewController.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/7.
//

import UIKit
import SnapKit

protocol AddCategoryViewControllerDelegate: AnyObject {
    func addCategoryViewControllerDidFinish(with categoryName: String)
}

class AddCategoryViewController: UIViewController {
    
    private var doneButton = UIButton(type: .custom)
    private var cancelButton = UIButton(type: .custom)
    private var categoryTitleLabel = UILabel()
    private var textFieldBackgroundView = UIView()
    private var categoryTextField = UITextField()
    
    private var addCategoryViewModel: AddCategoryViewModel = {
        return AddCategoryViewModel(
            doneTitle: NSLocalizedString("AddVC.done", comment: ""),
            cancelTitle: NSLocalizedString("AddVC.cancel", comment: ""),
            doneColor: UIColor.black,
            cancelColor: UIColor.black,
            doneBackgroundColor: UIColor.lightGray,
            cancelBackgroundColor: UIColor.lightGray,
            categoryTitleLabel: NSLocalizedString("AddVC.categoryTitleLabel", comment: ""),
            categoryTitleColor: UIColor.black)
    }()
    
    weak var delegate: AddCategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAutolayout()
    }
    
    private func setupUI() {
        // backgroundColor
        view.backgroundColor = .baseBackgroundColor
        
        // doneButton
        doneButton.setTitle(addCategoryViewModel.doneTitle, for: .normal)
        doneButton.setTitleColor(addCategoryViewModel.doneColor, for: .normal)
        doneButton.backgroundColor = addCategoryViewModel.doneBackgroundColor
        doneButton.layer.cornerRadius = 10
        doneButton.layer.masksToBounds = true
        doneButton.configuration = .bordered()
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        // set button size
        doneButton.sizeToFit()
        // create a UIBarButtonItem
        let doneBarButtonItem = UIBarButtonItem(customView: doneButton)
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        // cancelButton
        cancelButton.setTitle(addCategoryViewModel.cancelTitle, for: .normal)
        cancelButton.setTitleColor(addCategoryViewModel.cancelColor, for: .normal)
        cancelButton.setTitleColor(addCategoryViewModel.cancelColor, for: .highlighted)
        cancelButton.backgroundColor = addCategoryViewModel.cancelBackgroundColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        cancelButton.configuration = .bordered()
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        // set button size
        cancelButton.sizeToFit()
        // create a UIBarButtonItem
        let cancelBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.leftBarButtonItem = cancelBarButtonItem

        // textFieldBackgroundView
        view.addSubview(textFieldBackgroundView)
        textFieldBackgroundView.layer.cornerRadius = 10
        textFieldBackgroundView.backgroundColor = .white
        textFieldBackgroundView.layer.shadowColor = UIColor.black.cgColor
        textFieldBackgroundView.layer.shadowOpacity = 0.2
        textFieldBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        textFieldBackgroundView.layer.shadowRadius = 4
        
        // categoryTitleLabel
        categoryTitleLabel.text = addCategoryViewModel.categoryTitleLabel
        view.addSubview(categoryTitleLabel)
        
        // categoryTextField
        textFieldBackgroundView.addSubview(categoryTextField)
        
    }
    
    private func setupAutolayout() {
        categoryTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        categoryTitleLabel.textColor = addCategoryViewModel.categoryTitleColor
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        textFieldBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    @objc private func doneButtonTapped() {
        guard let categoryName = categoryTextField.text, !categoryName.isEmpty else { return }
        delegate?.addCategoryViewControllerDidFinish(with: categoryName)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }    

}
