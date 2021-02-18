//
//  ContentView.swift
//  SwiftUIList01
//
//  Created by Mamoru Sugihara on 2021/02/16.
//

import SwiftUI

struct ContentView: View {
	@State var selected = 0

	let items = (0..<100).map { $0 * 2 + 10001 }

	var body: some View {
		List {
			ForEach(0..<items.count) { i in
				ItemView(index: i, value: items[i], parent: Binding.constant(self))
					.onTapGesture {
						withAnimation() {
							selected = i
						}
					}
			}
		}
    }
}

struct ItemView: View {
	var index = 0
	var value = 0
	@Binding var parent: ContentView

	var body: some View {
		VStack {
			let showDetail = parent.selected == index
			Text("\(showDetail ? "> " : "")Item \(index) => \(value)")
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(showDetail ? "Detail 1\nDetail 2\nDetail 3" : "--")
				.multilineTextAlignment(.trailing)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}
		.contentShape(Rectangle())
	}

	init(index: Int, value: Int, parent: Binding<ContentView>) {
		self.index = index
		self.value = value
		self._parent = parent
		print("init: \(index)")
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
