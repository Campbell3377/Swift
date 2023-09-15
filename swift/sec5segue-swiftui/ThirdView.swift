//
//  ThirdView.swift
//  segue-swiftui
//
//  Created by Janaka Balasooriya on 1/16/23.
//

import SwiftUI

struct ThirdView: View {
    var dataFrom_Second: String
    var body: some View {
        Text(dataFrom_Second)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(dataFrom_Second: "")
    }
}
