//
//  ContentView.swift
//  SwiftUIList01
//
//  Created by Mamoru Sugihara on 2021/02/16.
//

import SwiftUI

struct ContentView: View {
	let items = (0..<10).map { $0 * 2 + 1 }
    var body: some View {
		List() {
			ForEach(items, id: \.self) { item in
				Text("Item \(item)")
					.padding()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
