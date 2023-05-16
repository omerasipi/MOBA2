//
// Created by Armando Shala on 08.05.23.
//

import SwiftUI

struct CustomPicker: View {
    var title: String
    @Binding var selection: Int
    var range: ClosedRange<Int>

    var body: some View {
        VStack {
            Text(title)
            Picker(title, selection: $selection) {
                ForEach(range, id: \.self) {
                    Text("\($0)")
                }
            }
                    .pickerStyle(.wheel)
                    .frame(height: 70)
        }
    }
}
