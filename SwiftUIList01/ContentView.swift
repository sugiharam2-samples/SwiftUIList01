//
//  ContentView.swift
//  SwiftUIList01
//
//  Created by Mamoru Sugihara on 2021/02/16.
//

import SwiftUI

struct ContentView: View {
	@State var selected = 0

	let items = (0..<10).map { $0 * 2 + 1 }

	var body: some View {
		List() {
			ForEach(0..<items.count) { i in
				VStack {
					Text("\(i == selected ? "> " : "")Item \(items[i])")
						.frame(maxWidth: .infinity, alignment: .leading)
					if (i == selected) {
						Text("Detail 1\nDetail 2\nDetail 3")
							.multilineTextAlignment(.trailing)
							.frame(maxWidth: .infinity, alignment: .trailing)
					}
				}
				.contentShape(Rectangle())
				.onTapGesture {
					print("Tap: \(selected) => \(i)")
					selected = i
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
