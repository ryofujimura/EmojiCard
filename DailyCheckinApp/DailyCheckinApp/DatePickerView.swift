//
//  DatePickerView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/4/22.
//

import SwiftUI

struct DatePickerView: View {
    @State private var date = Date()

    var body: some View {
        DatePicker(
            "",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(CompactDatePickerStyle())
        .padding()
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
