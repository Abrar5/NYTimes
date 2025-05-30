//
//  PickerView.swift
//  NYTimes
//
//  Created by Abrar on 30/05/2025.
//

import SwiftUI

struct PickerView: View {
    @Binding private var selectedValue: Int
    private var numberOptions: [Int]
    
    init(selectedValue: Binding<Int>, numberOptions: [Int]) {
        self._selectedValue = selectedValue
        self.numberOptions = numberOptions
    }
    var body: some View {
        HStack(spacing: 8) {
            Text("Select Number of Days:")
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
