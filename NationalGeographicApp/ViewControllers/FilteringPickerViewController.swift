//
//  FilteringPickerViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 01.11.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class FilteringPickerViewController: UIViewController {
    @IBOutlet var filteringPickerView: UIPickerView!
    
    let categories = Categorie.getCategorie()
    var choosenCategory = "All"
    var delegateCategory: ChoosenCategoryDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteringPickerView.dataSource = self
        filteringPickerView.delegate = self
    }

    @IBAction func doneChooseButton() {
        delegateCategory.getChoosenCategory(choosenCategory)
//        dismiss(animated: true)
    }

}

extension FilteringPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

extension FilteringPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let catigorie = categories[row]
        choosenCategory = catigorie.nameCategorie
        return choosenCategory
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenCategory = categories[row].nameCategorie
    }
}
