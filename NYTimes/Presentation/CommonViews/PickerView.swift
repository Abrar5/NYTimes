//
//  PickerView.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import SwiftUI

struct PickerView: View {
    private var pickerTitle: String
    @Binding private var selectedValue: Int
    private var numberOptions: [Int]
    
    init(pickerTitle: String, selectedValue: Binding<Int>, numberOptions: [Int]) {
        self.pickerTitle = pickerTitle
        self._selectedValue = selectedValue
        self.numberOptions = numberOptions
    }
    var body: some View {
        HStack(spacing: 8) {
            Text(pickerTitle)
                .foregroundStyle(.secondary)
            Picker("", selection: $selectedValue) {
                ForEach(numberOptions, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            Spacer()
        }
    }
}
